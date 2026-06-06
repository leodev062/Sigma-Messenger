package services

import (
	"errors"
	"strings"

	"sigma-server/internal/dto"
	"sigma-server/internal/domain/entities"
	"sigma-server/internal/repository/storage"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type ProfileService struct {
	repo *storage.AccountManager
}

func NewProfileService(repo *storage.AccountManager) *ProfileService {
	return &ProfileService{repo: repo}
}

func (s *ProfileService) GetByID(requesterID *uuid.UUID, userID uuid.UUID) (*entities.Account, error) {
	account, err := s.repo.FindByID(userID)
	if err != nil {
		return nil, err
	}
	if account.IsPrivateProfile && (requesterID == nil || *requesterID != account.ID) {
		return s.hidePrivateFields(account), nil
	}
	return account, nil
}

func (s *ProfileService) SyncRecipients(requesterID *uuid.UUID, ids []uuid.UUID) ([]entities.Account, error) {
	if len(ids) == 0 {
		return []entities.Account{}, nil
	}

	accounts, err := s.repo.FindByIDs(ids)
	if err != nil {
		return nil, err
	}

	for idx, account := range accounts {
		if account.IsPrivateProfile && (requesterID == nil || *requesterID != account.ID) {
			accounts[idx] = *s.hidePrivateFields(&account)
		}
	}

	return accounts, nil
}

func (s *ProfileService) UpdateProfile(userID uuid.UUID, req dto.UpdateAccountRequest) (*entities.Account, error) {
	account, err := s.repo.FindByID(userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("account not found")
		}
		return nil, err
	}

	if req.Username != "" {
		cleanUsername := strings.TrimPrefix(req.Username, "@")
		existing, err := s.repo.FindByUsername(cleanUsername)
		if err == nil && existing.ID != account.ID {
			return nil, errors.New("username already in use")
		}
		account.Username = &cleanUsername
	}
	if req.Name != "" {
		name := req.Name
		account.DisplayName = &name
	}
	if req.AvatarURL != "" {
		avatar := req.AvatarURL
		account.AvatarURL = &avatar
	}
	if req.Bio != "" {
		bio := req.Bio
		account.Bio = &bio
	}
	if req.Country != "" {
		country := req.Country
		account.Country = &country
	}

	if req.IsPrivate != nil {
		account.IsPrivateProfile = *req.IsPrivate
	}

	if err := s.repo.Update(account); err != nil {
		return nil, err
	}

	return account, nil
}

func (s *ProfileService) hidePrivateFields(account *entities.Account) *entities.Account {
	masked := *account
	// No Sigma, alguns campos são mantidos como nil em perfis privados para outros usuários.
	// No entanto, para o próprio usuário, todos os campos devem ser retornados.
	// Esta função só deve ser chamada para terceiros.
	masked.Email = nil
	masked.FCMToken = nil
	return &masked
}
