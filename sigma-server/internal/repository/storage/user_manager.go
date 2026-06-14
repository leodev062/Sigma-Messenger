package storage

import (
	"strings"

	"sigma-server/internal/domain/entities"

	"gorm.io/gorm"
)

type UserManager struct {
	db *gorm.DB
}

func NewUserManager(db *gorm.DB) *UserManager {
	return &UserManager{db: db}
}

func (m *UserManager) FindByID(id string) (*entities.User, error) {
	var user entities.User
	err := m.db.First(&user, "id = ?", id).Error
	return &user, err
}

func (m *UserManager) FindByUsername(username string) (*entities.User, error) {
	cleanUsername := strings.TrimPrefix(username, "@")
	var user entities.User
	err := m.db.Where("username = ?", cleanUsername).First(&user).Error
	return &user, err
}

func (m *UserManager) FindByEmail(email string) (*entities.User, error) {
	var user entities.User
	err := m.db.Where("email = ?", email).First(&user).Error
	return &user, err
}

func (m *UserManager) FindByPhone(phone string) (*entities.User, error) {
	var user entities.User
	err := m.db.Where("phone = ?", phone).First(&user).Error
	return &user, err
}

func (m *UserManager) FindByPhones(phones []string) ([]entities.User, error) {
	var users []entities.User
	err := m.db.Where("phone IN ?", phones).Find(&users).Error
	return users, err
}

func (m *UserManager) Create(user *entities.User) error {
	return m.db.Create(user).Error
}

func (m *UserManager) Update(user *entities.User) error {
	return m.db.Save(user).Error
}

func (m *UserManager) Delete(user *entities.User) error {
	return m.db.Delete(user).Error
}

func (m *UserManager) Search(term string, limit int) ([]entities.User, error) {
	cleanTerm := strings.TrimPrefix(term, "@")
	query := "%" + cleanTerm + "%"
	var users []entities.User
	err := m.db.Where("username ILIKE ? OR name ILIKE ?", query, query).
		Limit(limit).
		Find(&users).Error
	return users, err
}
