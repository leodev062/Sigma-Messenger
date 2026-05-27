package services

import (
	"errors"
	"strings"

	"sigma-server/ui/sigma/dto"
	"sigma-server/ui/sigma/entities"
	"sigma-server/ui/sigma/storage"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type ProfileService struct {
	repo *storage.AccountManager
}

func NewProfileService(repo *storage.AccountManager) *ProfileService {
	return &ProfileService{repo: repo}
}

func (s *ProfileService) GetByID(userID uuid.UUID) (*entities.Account, error) {
	return s.repo.FindByID(userID)
}

func (s *ProfileService) SyncRecipients(ids []uuid.UUID) ([]entities.Account, error) {
	if len(ids) == 0 {
		return []entities.Account{}, nil
	}
	return s.repo.FindByIDs(ids)
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
	if req.RelativeName != "" {
		relativeName := req.RelativeName
		account.RelativeName = &relativeName
	}
	if req.RelativeID != "" {
		relativeID, err := uuid.Parse(req.RelativeID)
		if err != nil {
			return nil, err
		}
		account.RelativeID = &relativeID
	}
	if req.IdentityKey != "" {
		account.IdentityKey = decodeBinaryKey(req.IdentityKey)
	}
	if req.SignedPreKeyID != 0 {
		id := req.SignedPreKeyID
		account.SignedPreKeyID = &id
	}
	if req.SignedPreKeyPublic != "" {
		account.SignedPreKeyPublic = decodeBinaryKey(req.SignedPreKeyPublic)
	}
	if req.SignedPreKeySignature != "" {
		account.SignedPreKeySignature = decodeBinaryKey(req.SignedPreKeySignature)
	}
	if req.RegistrationID != 0 {
		account.RegistrationID = &req.RegistrationID
	}
	if len(req.PreKeys) > 0 {
		preKeys := make(entities.PreKeyList, 0, len(req.PreKeys))
		for _, item := range req.PreKeys {
			preKeys = append(preKeys, entities.PreKeyEntry{ID: item.ID, Key: item.Key})
		}
		account.PreKeys = preKeys
	}

	if err := s.repo.Update(account); err != nil {
		return nil, err
	}

	return account, nil
}
