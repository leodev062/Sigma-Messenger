package storage

import (
	"sigma-server/internal/domain/entities"

	"gorm.io/gorm"
)

type DeviceSessionManager struct {
	db *gorm.DB
}

func NewDeviceSessionManager(db *gorm.DB) *DeviceSessionManager {
	return &DeviceSessionManager{db: db}
}

func (m *DeviceSessionManager) Save(device *entities.Device) error {
	return m.db.Save(device).Error
}

func (m *DeviceSessionManager) FindByUserID(userID string) ([]entities.Device, error) {
	var devices []entities.Device
	err := m.db.Where("user_id = ?", userID).Find(&devices).Error
	return devices, err
}

func (m *DeviceSessionManager) FindByDeviceID(deviceID string) (*entities.Device, error) {
	var device entities.Device
	err := m.db.Where("id = ?", deviceID).First(&device).Error
	return &device, err
}

func (m *DeviceSessionManager) DeleteByDeviceID(deviceID string) error {
	return m.db.Where("id = ?", deviceID).Delete(&entities.Device{}).Error
}

func (m *DeviceSessionManager) Touch(userID any, deviceID string, ip string) error {
	// Simple touch implementation
	return nil
}
