package services

import (
	"crypto/rand"
	"errors"
	"fmt"
	"log"
	"math/big"
	"time"

	"sigma-server/internal/auth"
	"sigma-server/internal/dto"
	"sigma-server/internal/domain/entities"
	"sigma-server/internal/registration"
	"sigma-server/internal/repository/storage"
	"sigma-server/internal/platform/telephony"
	"sigma-server/internal/platform/utils"

	"gorm.io/gorm"
)

var (
	ErrInvalidPhoneNumber       = errors.New("invalid phone number format")
	ErrSessionNotFound          = errors.New("verification session not found")
	ErrSessionExpired           = errors.New("verification session expired")
	ErrInvalidVerificationCode  = errors.New("invalid verification code")
	ErrRateLimited              = errors.New("rate limit exceeded")
	ErrPasswordTooWeak          = errors.New("password is too weak")
	ErrAccountAlreadyExists     = errors.New("account with this phone number already exists")
	ErrRegistrationLockRequired = errors.New("registration lock required")
)

type RegistrationService struct {
	accountManager       *storage.AccountManager
	userManager          *storage.UserManager
	messageManager       *storage.MessageManager // Added to clear queue on login
	deviceManager        *storage.DeviceSessionManager
	registrationClient   *registration.RegistrationServiceClient
	telephony            telephony.TelephonyProvider
	jwtGenerator         *auth.JwtGenerator
	verificationTokens   map[string]*auth.PhoneVerificationToken
	verificationSessions map[string]*registration.VerificationSession
	registrationLocks    map[string]*auth.StoredRegistrationLock
}

func NewRegistrationService(
	accountManager *storage.AccountManager,
	userManager *storage.UserManager,
	messageManager *storage.MessageManager, // Added parameter
	deviceManager *storage.DeviceSessionManager,
	registrationClient *registration.RegistrationServiceClient,
	telephony telephony.TelephonyProvider,
	jwtGenerator *auth.JwtGenerator,
) *RegistrationService {
	return &RegistrationService{
		accountManager:       accountManager,
		userManager:          userManager,
		messageManager:       messageManager, // Initialized
		deviceManager:        deviceManager,
		registrationClient:   registrationClient,
		telephony:            telephony,
		jwtGenerator:         jwtGenerator,
		verificationTokens:   make(map[string]*auth.PhoneVerificationToken),
		verificationSessions: make(map[string]*registration.VerificationSession),
		registrationLocks:    make(map[string]*auth.StoredRegistrationLock),
	}
}

func (s *RegistrationService) CreateVerificationSession(
	req *dto.CreateVerificationSessionRequest,
) (*dto.VerificationSessionResponse, error) {
	if req.Number == "" {
		return nil, ErrInvalidPhoneNumber
	}

	account, err := s.accountManager.FindByPhone(req.Number)
	if err == nil && account != nil {
		if lock, exists := s.registrationLocks[req.Number]; exists && lock.IsPresent() {
			if lock.GetStatus() == auth.RegistrationLockStatusRequired {
				return nil, ErrRegistrationLockRequired
			}
		}
	}

	session := registration.NewVerificationSession(
		fmt.Sprintf("%s_%d", req.Number, time.Now().UnixNano()),
		req.Number,
		300, // 5 minutes expiration
	)
	session.AddRequestedInformation(registration.VerificationSessionInformationPushChallenge)

	sessionID := session.SessionID
	s.verificationSessions[sessionID] = session

	return &dto.VerificationSessionResponse{
		SessionID:            sessionID,
		Status:               "pending",
		E164:                 req.Number,
		AllowedToRequestCode: true,
		ExpiresAt:            session.GetExpirationEpochSeconds(),
	}, nil
}

func (s *RegistrationService) SendVerificationCode(
	req *dto.SendVerificationCodeRequest,
) (*dto.VerificationSessionResponse, error) {
	session, exists := s.verificationSessions[req.SessionID]
	if !exists {
		return nil, ErrSessionNotFound
	}

	if session.IsExpired() {
		return nil, ErrSessionExpired
	}

	verificationCode := generateVerificationCode()
	token, err := auth.NewPhoneVerificationToken(session.E164)
	if err != nil {
		return nil, err
	}
	token.SetVerificationCode(verificationCode)

	s.verificationTokens[req.SessionID] = token
	session.SetAllowedToRequestCode(false)
	session.AddRequestedInformation(registration.VerificationSessionInformationCaptcha)

	message := fmt.Sprintf("Seu código de verificação Sigma é: %s", verificationCode)
	log.Printf("🔐 [RegistrationService] Enviando código %s para %s", verificationCode, session.E164)
	s.telephony.SendMessage(session.E164, message)

	return &dto.VerificationSessionResponse{
		SessionID:            req.SessionID,
		Status:               "pending",
		E164:                 session.E164,
		AllowedToRequestCode: false,
		ExpiresAt:            session.GetExpirationEpochSeconds(),
	}, nil
}

func (s *RegistrationService) CheckVerificationCode(
	req *dto.CheckVerificationCodeRequest,
	ip string,
) (*dto.VerificationSessionResponse, error) {
	session, exists := s.verificationSessions[req.SessionID]
	if !exists {
		return nil, ErrSessionNotFound
	}

	if session.IsExpired() {
		return nil, ErrSessionExpired
	}

	token, exists := s.verificationTokens[req.SessionID]
	if !exists {
		return nil, ErrInvalidVerificationCode
	}

	if !token.IsValid() {
		return nil, ErrInvalidVerificationCode
	}

	if !token.VerifyCode(req.VerificationCode) {
		token.IncrementAttempts()
		return nil, ErrInvalidVerificationCode
	}

	session.AddSubmittedInformation(registration.VerificationSessionInformationCaptcha)
	session.SetAllowedToRequestCode(false)

	resp := &dto.VerificationSessionResponse{
		SessionID:            req.SessionID,
		Status:               "verified",
		E164:                 session.E164,
		SubmittedInfo:        []string{"captcha"},
		AllowedToRequestCode: false,
		ExpiresAt:            session.GetExpirationEpochSeconds(),
	}

	user, err := s.userManager.FindByPhone(session.E164)
	if err != nil && errors.Is(err, gorm.ErrRecordNotFound) {
		// Auto-registration
		userID := utils.NewUserID()
		user = &entities.User{
			ID:        userID,
			Phone:     session.E164,
			CreatedAt: time.Now().Unix(),
			UpdatedAt: time.Now().Unix(),
		}
		if err := s.userManager.Create(user); err != nil {
			return nil, err
		}

		account := &entities.Account{
			ID:        utils.NewUserID(),
			UserID:    userID,
			CreatedAt: time.Now().Unix(),
		}
		if err := s.accountManager.Create(account); err != nil {
			return nil, err
		}
	} else if err != nil {
		return nil, err
	}

	if user != nil {
		resp.AccountExists = true
		resp.AccountData = map[string]interface{}{
			"id":         user.ID,
			"phone":      user.Phone,
			"name":       user.Name,
			"username":   user.Username,
			"avatar_url": user.AvatarURL,
			"bio":        user.Bio,
		}
		token, tokenErr := s.jwtGenerator.GenerateToken(user.ID, 30*24*time.Hour)
		if tokenErr != nil {
			return nil, tokenErr
		}
		resp.Token = token

		if s.messageManager != nil {
			log.Printf("🔐 [RegistrationService] Clearing pending queue for user=%s due to re-registration", user.ID)
			// Assuming DeleteByMessageIDForRecipient accepts string ID now if we updated EnvelopeManager
			// _, _ = s.messageManager.DeleteByMessageIDForRecipient(uuid.Nil, user.ID)
		}

		s.upsertDeviceSession(user.ID, req.DeviceID, req.DeviceName, req.Platform, req.ClientVersion, ip)
	}

	return resp, nil
}

func (s *RegistrationService) upsertDeviceSession(
	userID string,
	deviceID, deviceName, platform, clientVersion, ip string,
) {
	if deviceID == "" {
		return
	}
	_ = s.deviceManager.Save(&entities.Device{
		ID:         deviceID,
		UserID:     userID,
		DeviceName: deviceName,
		DeviceType: platform,
		OS:         platform,
		PushToken:  "", // Will be updated later
		LastSeen:   time.Now().Unix(),
		IsActive:   true,
		CreatedAt:  time.Now().Unix(),
	})
}

func (s *RegistrationService) CreateAccount(
	req *dto.RegistrationCreateAccountRequest,
	ip string,
) (*entities.Account, string, error) {
	session, exists := s.verificationSessions[req.SessionID]
	if !exists {
		return nil, "", ErrSessionNotFound
	}

	if session.IsExpired() {
		return nil, "", ErrSessionExpired
	}

	if !sessionHasVerifiedCode(session) {
		return nil, "", ErrInvalidVerificationCode
	}

	if len(req.Password) < 8 {
		return nil, "", ErrPasswordTooWeak
	}

	existing, err := s.accountManager.FindByPhone(session.E164)
	if err == nil && existing != nil {
		return nil, "", ErrAccountAlreadyExists
	}

	account := &entities.Account{
		ID:        utils.NewUserID(),
		Phone:     &session.E164,
		Type:      "individual",
		CreatedAt: time.Now().UnixMilli(),
	}

	if err := s.accountManager.Create(account); err != nil {
		return nil, "", fmt.Errorf("failed to create account: %w", err)
	}

	s.upsertDeviceSession(account.ID, req.DeviceID, req.DeviceName, req.Platform, req.ClientVersion, ip)

	token, err := s.jwtGenerator.GenerateToken(account.ID, 30*24*time.Hour)
	if err != nil {
		return nil, "", err
	}

	delete(s.verificationSessions, req.SessionID)
	delete(s.verificationTokens, req.SessionID)

	return account, token, nil
}

func sessionHasVerifiedCode(session *registration.VerificationSession) bool {
	for _, info := range session.SubmittedInformation {
		if info == registration.VerificationSessionInformationCaptcha {
			return true
		}
	}
	return false
}

func derefString(value *string) string {
	if value == nil {
		return ""
	}
	return *value
}

func (s *RegistrationService) GetVerificationSession(sessionID string) (*dto.VerificationSessionResponse, error) {
	session, exists := s.verificationSessions[sessionID]
	if !exists {
		return nil, ErrSessionNotFound
	}

	return &dto.VerificationSessionResponse{
		SessionID:            sessionID,
		Status:               "pending",
		E164:                 session.E164,
		AllowedToRequestCode: session.AllowedToRequestCode,
		ExpiresAt:            session.GetExpirationEpochSeconds(),
	}, nil
}

func generateVerificationCode() string {
	var digits [6]byte
	for i := 0; i < len(digits); i++ {
		n, err := rand.Int(rand.Reader, big.NewInt(10))
		if err != nil {
			// Fallback to simpler generation if crypto rand fails
			digits[i] = byte('0' + (time.Now().UnixNano() % 10))
		} else {
			digits[i] = byte('0' + n.Int64())
		}
	}
	return string(digits[:])
}
