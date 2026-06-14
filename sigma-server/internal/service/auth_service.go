package services

import (
	"errors"
	"time"

	"sigma-server/internal/auth"
	"sigma-server/internal/dto"
	"sigma-server/internal/domain/entities"
	"sigma-server/internal/repository/storage"

	"gorm.io/gorm"
)

type DeviceInfo struct {
	DeviceID      string
	DeviceName    string
	Platform      string
	ClientVersion string
	IPAddress     string
}

type AuthService struct {
	accounts      *storage.AccountManager
	users         *storage.UserManager
	devices       *storage.DeviceSessionManager
	jwtGenerator  *auth.JwtGenerator
	phoneVerifier *auth.PhoneVerificationManager
}

func NewAuthService(accounts *storage.AccountManager, users *storage.UserManager, devices *storage.DeviceSessionManager, jwtGenerator *auth.JwtGenerator, phoneVerifier *auth.PhoneVerificationManager) *AuthService {
	return &AuthService{accounts: accounts, users: users, devices: devices, jwtGenerator: jwtGenerator, phoneVerifier: phoneVerifier}
}

func (s *AuthService) RequestCode(phone string) error {
	return s.phoneVerifier.GenerateAndSendCode(phone)
}

func (s *AuthService) Login(req dto.LoginRequest, ip string) (*dto.LoginResponse, error) {
	if !s.phoneVerifier.VerifyCode(req.Phone, req.Code) {
		return nil, errors.New("invalid verification code")
	}

	user, err := s.users.FindByPhone(req.Phone)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			// Auto-registration on Login
			userID := uuid.New().String()
			user = &entities.User{
				ID:        userID,
				Phone:     req.Phone,
				CreatedAt: time.Now().Unix(),
				UpdatedAt: time.Now().Unix(),
			}
			if err := s.users.Create(user); err != nil {
				return nil, err
			}

			account := &entities.Account{
				ID:        uuid.New().String(),
				UserID:    userID,
				CreatedAt: time.Now().Unix(),
			}
			if err := s.accounts.Create(account); err != nil {
				return nil, err
			}
		} else {
			return nil, err
		}
	}

	token, err := s.jwtGenerator.GenerateToken(user.ID, 30*24*time.Hour)
	if err != nil {
		return nil, err
	}

	// Register/Update device session
	if req.DeviceID != "" {
		device := &entities.Device{
			ID:         req.DeviceID,
			UserID:     user.ID,
			DeviceName: req.DeviceName,
			DeviceType: req.Platform,
			OS:         req.Platform,
			LastSeen:   time.Now().Unix(),
			IsActive:   true,
			CreatedAt:  time.Now().Unix(),
		}
		_ = s.devices.Save(device)
	}

	return &dto.LoginResponse{Token: token, User: user}, nil
}
