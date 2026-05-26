package services

import (
	"errors"
	"time"

	"sigma-server/ui/sigma/auth"
	"sigma-server/ui/sigma/dto"
	"sigma-server/ui/sigma/entities"
	"sigma-server/ui/sigma/storage"

	"gorm.io/gorm"
)

type AuthService struct {
	accounts      *storage.AccountManager
	jwtGenerator  *auth.JwtGenerator
	phoneVerifier *auth.PhoneVerificationManager
}

func NewAuthService(accounts *storage.AccountManager, jwtGenerator *auth.JwtGenerator, phoneVerifier *auth.PhoneVerificationManager) *AuthService {
	return &AuthService{accounts: accounts, jwtGenerator: jwtGenerator, phoneVerifier: phoneVerifier}
}

func (s *AuthService) RequestCode(phone string) error {
	return s.phoneVerifier.GenerateAndSendCode(phone)
}

func (s *AuthService) Login(req dto.LoginRequest) (*dto.LoginResponse, error) {
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

	return &dto.LoginResponse{Token: token, User: account}, nil
}
