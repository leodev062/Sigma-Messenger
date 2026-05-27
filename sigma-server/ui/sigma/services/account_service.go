package services

import (
	"encoding/base64"
	"errors"

	"sigma-server/ui/sigma/dto"
	"sigma-server/ui/sigma/entities"
	"sigma-server/ui/sigma/storage"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type AccountService struct {
	repo *storage.AccountManager
}

func NewAccountService(repo *storage.AccountManager) *AccountService {
	return &AccountService{repo: repo}
}

func decodeBinaryKey(value string) []byte {
	if value == "" {
		return nil
	}

	decoded, err := base64.StdEncoding.DecodeString(value)
	if err != nil {
		return []byte(value)
	}

	return decoded
}

func encodeBinaryKey(value []byte) string {
	if len(value) == 0 {
		return ""
	}
	return base64.StdEncoding.EncodeToString(value)
}

func (s *AccountService) CreateAccount(req dto.CreateAccountRequest) (*entities.Account, error) {
	account := &entities.Account{
		Type:                  "individual",
		Phone:                 &req.Phone,
		DisplayName:           &req.Name,
		Username:              &req.Username,
		AvatarURL:             &req.AvatarURL,
		Bio:                   &req.Bio,
		IdentityKey:           decodeBinaryKey(req.IdentityKey),
		SignedPreKeyID:        nil,
		SignedPreKeyPublic:    decodeBinaryKey(req.SignedPreKeyPublic),
		SignedPreKeySignature: decodeBinaryKey(req.SignedPreKeySignature),
		PreKeys:               make(entities.PreKeyList, 0, len(req.PreKeys)),
	}
	if req.Email != "" {
		email := req.Email
		account.Email = &email
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
	if req.SignedPreKeyID != 0 {
		id := req.SignedPreKeyID
		account.SignedPreKeyID = &id
	}
	if req.RegistrationID != 0 {
		account.RegistrationID = &req.RegistrationID
	}
	if len(req.PreKeys) > 0 {
		account.PreKeys = make(entities.PreKeyList, 0, len(req.PreKeys))
		for _, item := range req.PreKeys {
			account.PreKeys = append(account.PreKeys, entities.PreKeyEntry{ID: item.ID, Key: item.Key})
		}
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

func (s *AccountService) GetKeys(userID uuid.UUID) (*dto.KeysResponse, error) {
	account, preKeys, err := s.repo.FetchKeyBundle(userID)
	if err != nil {
		return nil, err
	}

	response := &dto.KeysResponse{}
	if account.RegistrationID != nil {
		response.RegistrationID = *account.RegistrationID
	}
	if account.SignedPreKeyID != nil {
		response.SignedPreKeyID = *account.SignedPreKeyID
	}
	if len(account.SignedPreKeyPublic) > 0 {
		response.SignedPreKeyPublic = encodeBinaryKey(account.SignedPreKeyPublic)
	}
	if len(account.SignedPreKeySignature) > 0 {
		response.SignedPreKeySignature = encodeBinaryKey(account.SignedPreKeySignature)
	}
	if len(account.IdentityKey) > 0 {
		response.IdentityKey = encodeBinaryKey(account.IdentityKey)
	}

	if len(preKeys) > 0 {
		preKey, err := s.repo.ConsumePreKey(userID)
		if err != nil {
			return nil, err
		}
		response.PreKeyID = preKey.KeyID
		response.PreKeyPublic = encodeBinaryKey(preKey.PublicKey)
	}

	return response, nil
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
