package storage

import (
	"log"
	"time"

	"sigma-server/internal/domain/entities"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type DeviceSessionManager struct {
	db *gorm.DB
}

func NewDeviceSessionManager(db *gorm.DB) *DeviceSessionManager {
	return &DeviceSessionManager{db: db}
}

func (m *DeviceSessionManager) Save(session *entities.UserDeviceSession) error {
	return m.db.Save(session).Error
}

func (m *DeviceSessionManager) Upsert(session *entities.UserDeviceSession) error {
	return m.db.Clauses(clause.OnConflict{
		Columns:   []clause.Column{{Name: "user_id"}, {Name: "device_id"}},
		DoUpdates: clause.AssignmentColumns([]string{"device_name", "platform", "client_version", "ip_address", "last_active_at", "updated_at"}),
	}).Create(session).Error
}

func (m *DeviceSessionManager) Touch(userID uuid.UUID, deviceID string, ip string) error {
	log.Printf("Touch: Updating session for user=%s device=%s ip=%s", userID, deviceID, ip)
	return m.db.Model(&entities.UserDeviceSession{}).
		Where("user_id = ? AND device_id = ?", userID, deviceID).
		Updates(map[string]interface{}{
			"ip_address":     ip,
			"last_active_at": time.Now(),
		}).Error
}

func (m *DeviceSessionManager) FindByUserID(userID uuid.UUID) ([]entities.UserDeviceSession, error) {
	var sessions []entities.UserDeviceSession
	err := m.db.Where("user_id = ?", userID).Find(&sessions).Error
	return sessions, err
}

func (m *DeviceSessionManager) FindByDeviceID(deviceID string) (*entities.UserDeviceSession, error) {
	var session entities.UserDeviceSession
	err := m.db.Where("device_id = ?", deviceID).First(&session).Error
	return &session, err
}

func (m *DeviceSessionManager) Delete(id uint) error {
	return m.db.Delete(&entities.UserDeviceSession{}, id).Error
}

func (m *DeviceSessionManager) DeleteByDeviceID(deviceID string) error {
	return m.db.Where("device_id = ?", deviceID).Delete(&entities.UserDeviceSession{}).Error
}
