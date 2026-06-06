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
	devices       *storage.DeviceSessionManager
	jwtGenerator  *auth.JwtGenerator
	phoneVerifier *auth.PhoneVerificationManager
}

func NewAuthService(accounts *storage.AccountManager, devices *storage.DeviceSessionManager, jwtGenerator *auth.JwtGenerator, phoneVerifier *auth.PhoneVerificationManager) *AuthService {
	return &AuthService{accounts: accounts, devices: devices, jwtGenerator: jwtGenerator, phoneVerifier: phoneVerifier}
}

func (s *AuthService) RequestCode(phone string) error {
	return s.phoneVerifier.GenerateAndSendCode(phone)
}

func (s *AuthService) Login(req dto.LoginRequest, ip string) (*dto.LoginResponse, error) {
	if !s.phoneVerifier.VerifyCode(req.Phone, req.Code) {
		return nil, errors.New("invalid verification code")
	}

	account, err := s.accounts.FindByPhone(req.Phone)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			account = &entities.Account{
				Phone:       &req.Phone,
				DisplayName: &req.Phone,
				Type:        "individual",
			}
			if err := s.accounts.Create(account); err != nil {
				return nil, err
			}
		} else {
			return nil, err
		}
	}

	token, err := s.jwtGenerator.GenerateToken(account.ID.String(), 30*24*time.Hour)
	if err != nil {
		return nil, err
	}

	// Register/Update device session (Professional Algorithm)
	if req.DeviceID != "" {
		session := &entities.UserDeviceSession{
			UserID:        account.ID,
			DeviceID:      req.DeviceID,
			DeviceName:    req.DeviceName,
			Platform:      req.Platform,
			ClientVersion: req.ClientVersion,
			IPAddress:     ip,
			LastActiveAt:  time.Now(),
		}
		_ = s.devices.Upsert(session)
	}

	return &dto.LoginResponse{Token: token, User: account}, nil
}
