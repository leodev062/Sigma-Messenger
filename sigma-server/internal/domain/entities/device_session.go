package entities

import (
	"time"

	"github.com/google/uuid"
)

type UserDeviceSession struct {
	ID            uint      `gorm:"primaryKey;autoIncrement" json:"id"`
	UserID        uuid.UUID `gorm:"column:user_id;type:uuid;index;uniqueIndex:idx_user_device" json:"user_id"`
	DeviceID      string    `gorm:"column:device_id;uniqueIndex:idx_user_device" json:"device_id"`
	DeviceName    string    `gorm:"column:device_name" json:"device_name"`
	Platform      string    `gorm:"column:platform" json:"platform"`
	ClientVersion string    `gorm:"column:client_version" json:"client_version"`
	IPAddress     string    `gorm:"column:ip_address" json:"ip_address"`
	LastActiveAt  time.Time `gorm:"column:last_active_at" json:"last_active_at"`
	CreatedAt     time.Time `gorm:"default:CURRENT_TIMESTAMP" json:"created_at"`
	UpdatedAt     time.Time `gorm:"default:CURRENT_TIMESTAMP" json:"updated_at"`
}

func (UserDeviceSession) TableName() string {
	return "user_device_sessions"
}
