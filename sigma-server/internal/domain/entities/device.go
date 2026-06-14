package entities

type Device struct {
	ID         string `gorm:"primaryKey" json:"id"`
	UserID     string `json:"user_id"`
	DeviceName string `json:"device_name"`
	DeviceType string `json:"device_type"`
	OS         string `json:"os"`
	PushToken  string `json:"push_token"`
	LastSeen   int64  `json:"last_seen"`
	IsActive   bool   `gorm:"default:true" json:"is_active"`
	CreatedAt  int64  `json:"created_at"`
}

func (Device) TableName() string {
	return "devices"
}
