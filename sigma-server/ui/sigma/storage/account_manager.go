package storage

import (
	"strings"

	"sigma-server/ui/sigma/entities"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type AccountManager struct {
	db *gorm.DB
}

func NewAccountManager(db *gorm.DB) *AccountManager {
	return &AccountManager{db: db}
}

func (m *AccountManager) FindByID(id uuid.UUID) (*entities.Account, error) {
	var account entities.Account
	err := m.db.First(&account, id).Error
	return &account, err
}

func (m *AccountManager) FindByFirebaseUID(uid string) (*entities.Account, error) {
	var account entities.Account
	err := m.db.Where("firebase_uid = ?", uid).First(&account).Error
	return &account, err
}

func (m *AccountManager) FindByUsername(username string) (*entities.Account, error) {
	cleanUsername := strings.TrimPrefix(username, "@")
	var account entities.Account
	err := m.db.Where("username = ?", cleanUsername).First(&account).Error
	return &account, err
}

func (m *AccountManager) FindByPhone(phone string) (*entities.Account, error) {
	var account entities.Account
	err := m.db.Where("phone = ?", phone).First(&account).Error
	return &account, err
}

func (m *AccountManager) Create(account *entities.Account) error {
	return m.db.Create(account).Error
}

func (m *AccountManager) Update(account *entities.Account) error {
	return m.db.Save(account).Error
}

func (m *AccountManager) Delete(account *entities.Account) error {
	return m.db.Delete(account).Error
}

func (m *AccountManager) Search(term string, limit int) ([]entities.Account, error) {
	cleanTerm := strings.TrimPrefix(term, "@")
	query := "%" + cleanTerm + "%"
	var accounts []entities.Account
	err := m.db.Where("username ILIKE ? OR display_name ILIKE ?", query, query).
		Limit(limit).
		Find(&accounts).Error
	return accounts, err
}

func (m *AccountManager) FindByPhones(phones []string) ([]entities.Account, error) {
	var accounts []entities.Account
	err := m.db.Where("phone IN ?", phones).Find(&accounts).Error
	return accounts, err
}

func (m *AccountManager) FindByIDs(ids []uuid.UUID) ([]entities.Account, error) {
	var accounts []entities.Account
	err := m.db.Where("id IN ?", ids).Find(&accounts).Error
	return accounts, err
}

func (m *AccountManager) UpdatePreKeys(accountID uuid.UUID, keys [][]byte) error {
	return m.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Where("recipient_id = ?", accountID).Delete(&entities.PreKey{}).Error; err != nil {
			return err
		}

		for i, key := range keys {
			preKey := entities.PreKey{
				RecipientID: accountID,
				KeyID:       i + 1,
				PublicKey:   append([]byte(nil), key...),
			}
			if err := tx.Create(&preKey).Error; err != nil {
				return err
			}
		}

		return nil
	})
}

func (m *AccountManager) SaveKeyBundle(accountID uuid.UUID, payload []byte) error {
	return m.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.First(&entities.Account{ID: accountID}).Error; err != nil {
			return err
		}

		bundle := entities.KeyBundle{
			AccountID: accountID,
			Payload:   append([]byte(nil), payload...),
		}

		if err := tx.Where("account_id = ?", accountID).Delete(&entities.KeyBundle{}).Error; err != nil {
			return err
		}

		if err := tx.Create(&bundle).Error; err != nil {
			return err
		}

		return nil
	})
}

func (m *AccountManager) FetchRawKeyBundle(accountID uuid.UUID) ([]byte, error) {
	var bundle entities.KeyBundle
	if err := m.db.Where("account_id = ?", accountID).First(&bundle).Error; err != nil {
		return nil, err
	}
	return append([]byte(nil), bundle.Payload...), nil
}

func (m *AccountManager) FetchKeyBundle(accountID uuid.UUID) (*entities.Account, []entities.PreKey, error) {
	var account entities.Account
	if err := m.db.First(&account, "id = ?", accountID).Error; err != nil {
		return nil, nil, err
	}

	var preKeys []entities.PreKey
	if err := m.db.Where("recipient_id = ?", accountID).Order("key_id asc").Find(&preKeys).Error; err != nil {
		return &account, nil, err
	}

	return &account, preKeys, nil
}

func (m *AccountManager) ConsumePreKey(accountID uuid.UUID) (*entities.PreKey, error) {
	var preKey entities.PreKey
	err := m.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Where("recipient_id = ?", accountID).Order("key_id asc").First(&preKey).Error; err != nil {
			return err
		}
		if err := tx.Delete(&preKey).Error; err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		return nil, err
	}
	return &preKey, nil
}
