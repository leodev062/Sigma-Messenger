package storage

import (
	"sigma-server/internal/domain/entities"

	"gorm.io/gorm"
)

type AccountManager struct {
	db *gorm.DB
}

func NewAccountManager(db *gorm.DB) *AccountManager {
	return &AccountManager{db: db}
}

func (m *AccountManager) FindByID(id any) (*entities.Account, error) {
	var account entities.Account
	err := m.db.First(&account, "id = ?", id).Error
	return &account, err
}

func (m *AccountManager) FetchRawKeyBundle(userID any) ([]byte, error) {
	// TODO: Implement actual key storage.
	// For now, returning dummy or checking if I missed a table.
	return nil, nil
}

func (m *AccountManager) SaveKeyBundle(userID any, payload []byte) error {
	// TODO: Implement actual key storage.
	return nil
}

func (m *AccountManager) GetPreKeyCount(userID any) (int64, error) {
	return 0, nil
}

func (m *AccountManager) FindByEmail(email string) (*entities.Account, error) {
	var account entities.Account
	err := m.db.Where("email = ?", email).First(&account).Error
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

func (m *AccountManager) FindByIDs(ids []string) ([]entities.Account, error) {
	var accounts []entities.Account
	err := m.db.Where("id IN ?", ids).Find(&accounts).Error
	return accounts, err
}
