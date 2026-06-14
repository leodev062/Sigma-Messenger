package entities

type DeliveryLog struct {
	ID        string `gorm:"primaryKey" json:"id"`
	MessageID string `json:"message_id"`
	UserID    string `json:"user_id"`
	Status    string `json:"status"`
	Timestamp int64  `json:"timestamp"`
}

func (DeliveryLog) TableName() string {
	return "delivery_log"
}
