package services

import (
	"errors"

	"sigma-server/internal/dto"
	"sigma-server/internal/domain/entities"
	"sigma-server/internal/repository/storage"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type AccountService struct {
	repo *storage.AccountManager
}

func NewAccountService(repo *storage.AccountManager) *AccountService {
	return &AccountService{repo: repo}
}

func (s *AccountService) CreateAccount(req dto.CreateAccountRequest) (*entities.Account, error) {
	account := &entities.Account{
		Type:             "individual",
		Phone:            &req.Phone,
		DisplayName:      &req.Name,
		Username:         &req.Username,
		AvatarURL:        &req.AvatarURL,
		Bio:              &req.Bio,
		IsPrivateProfile: req.IsPrivate,
	}
	if req.Email != "" {
		email := req.Email
		account.Email = &email
	}
	if req.Country != "" {
		country := req.Country
		account.Country = &country
	}
	if err := s.repo.Create(account); err != nil {
		return nil, err
	}
	return account, nil
}

func (s *AccountService) GetAccountByID(userID uuid.UUID) (*entities.Account, error) {
	return s.repo.FindByID(userID)
}

func (s *AccountService) DeleteAccount(userID uuid.UUID) error {
	account, err := s.repo.FindByID(userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errors.New("account not found")
		}
		return err
	}
	return s.repo.Delete(account)
}

func (s *AccountService) GetKeys(userID uuid.UUID) ([]byte, error) {
	return s.repo.FetchRawKeyBundle(userID)
}

func (s *AccountService) SavePreKeyBundle(userID uuid.UUID, payload []byte) error {
	if len(payload) == 0 {
		return errors.New("prekey payload is required")
	}
	return s.repo.SaveKeyBundle(userID, append([]byte(nil), payload...))
}

func (s *AccountService) GetPreKeyBundle(userID uuid.UUID) ([]byte, error) {
	return s.repo.FetchRawKeyBundle(userID)
}

func (s *AccountService) UpdateFCMToken(userID uuid.UUID, token string) error {
	account, err := s.repo.FindByID(userID)
	if err != nil {
		return err
	}
	account.FCMToken = &token
	return s.repo.Update(account)
}
