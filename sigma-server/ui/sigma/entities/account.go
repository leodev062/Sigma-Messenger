package entities

import (
	"database/sql/driver"
	"encoding/json"
	"errors"
	"time"

	"github.com/google/uuid"
)

type PreKeyEntry struct {
	ID  int    `json:"id"`
	Key string `json:"key"`
}

type PreKeyList []PreKeyEntry

func (p PreKeyList) Value() (driver.Value, error) {
	if p == nil {
		return "[]", nil
	}
	return json.Marshal(p)
}

func (p *PreKeyList) Scan(value interface{}) error {
	if value == nil {
		*p = PreKeyList{}
		return nil
	}

	bytes, ok := value.([]byte)
	if !ok {
		return errors.New("failed to scan PreKeyList")
	}

	return json.Unmarshal(bytes, p)
}

type Account struct {
	ID                    uuid.UUID  `gorm:"type:uuid;default:gen_random_uuid();primaryKey" json:"id"`
	Type                  string     `gorm:"default:'individual'" json:"type"`
	FirebaseUID           *string    `gorm:"column:firebase_uid;unique" json:"firebase_uid,omitempty"`
	Phone                 *string    `gorm:"unique" json:"phone"`
	DisplayName           *string    `gorm:"column:display_name" json:"name"`
	Username              *string    `gorm:"unique" json:"username"`
	AvatarURL             *string    `gorm:"column:avatar_url" json:"avatar_url"`
	IsOnline              bool       `gorm:"default:false" json:"is_online"`
	FCMToken              *string    `gorm:"column:fcm_token" json:"fcm_token"`
	Email                 *string    `gorm:"unique" json:"email"`
	Bio                   *string    `gorm:"default:'Olá! Estou usando o Sigma.'" json:"bio"`
	Country               *string    `gorm:"column:country" json:"country,omitempty"`
	RelativeName          *string    `gorm:"column:relative_name" json:"relative_name,omitempty"`
	RelativeID            *uuid.UUID `gorm:"column:relative_id;type:uuid" json:"relative_id,omitempty"`
	VerificationType      string     `gorm:"column:verification_type;default:'none'" json:"verification_type"`
	OwnerID               *uuid.UUID `gorm:"column:owner_id;type:uuid" json:"owner_id"`
	ParticipantCount      int        `gorm:"column:participant_count;default:0" json:"participant_count"`
	CreatedAt             time.Time  `gorm:"default:CURRENT_TIMESTAMP" json:"created_at"`
	UpdatedAt             time.Time  `gorm:"default:CURRENT_TIMESTAMP" json:"updated_at"`
	IdentityKey           []byte     `gorm:"column:identity_key;type:bytea" json:"identity_key,omitempty"`
	SignedPreKey          []byte     `gorm:"column:signed_pre_key;type:bytea" json:"signed_pre_key,omitempty"`
	RegistrationID        *int64     `gorm:"column:registration_id" json:"registration_id"`
	SignedPreKeyID        *int       `gorm:"column:signed_pre_key_id" json:"signed_pre_key_id"`
	SignedPreKeyPublic    []byte     `gorm:"column:signed_pre_key_public;type:bytea" json:"signed_pre_key_public,omitempty"`
	SignedPreKeySignature []byte     `gorm:"column:signed_pre_key_signature;type:bytea" json:"signed_pre_key_signature,omitempty"`
	PreKeys               PreKeyList `gorm:"-" json:"pre_keys,omitempty"`
}

func (Account) TableName() string {
	return "recipients"
}
