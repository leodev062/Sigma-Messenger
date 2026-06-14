package entities

type User struct {
	ID        string `gorm:"primaryKey" json:"id"`
	Phone     string `gorm:"uniqueIndex" json:"phone"`
	Name      string `json:"name"`
	Username  string `gorm:"uniqueIndex" json:"username"`
	Email     string `gorm:"uniqueIndex" json:"email"`
	Bio       string `json:"bio"`
	AvatarURL string `json:"avatar_url"`
	IsBot     bool   `gorm:"default:false" json:"is_bot"`
	CreatedAt int64  `json:"created_at"`
	UpdatedAt int64  `json:"updated_at"`
}

func (User) TableName() string {
	return "users"
}
