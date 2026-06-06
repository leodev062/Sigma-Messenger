package auth

import (
	"crypto/rand"
	"encoding/hex"
	"time"
)

const (
	PhoneVerificationTokenExpirationTime = 30 * time.Minute
)

type PhoneVerificationToken struct {
	Token            string
	CreatedAt        time.Time
	ExpiresAt        time.Time
	PhoneNumber      string
	VerificationCode string
	Attempts         int
	MaxAttempts      int
}

func NewPhoneVerificationToken(phoneNumber string) (*PhoneVerificationToken, error) {
	token := make([]byte, 24)
	_, err := rand.Read(token)
	if err != nil {
		return nil, err
	}

	now := time.Now()
	return &PhoneVerificationToken{
		Token:       hex.EncodeToString(token),
		CreatedAt:   now,
		ExpiresAt:   now.Add(PhoneVerificationTokenExpirationTime),
		PhoneNumber: phoneNumber,
		Attempts:    0,
		MaxAttempts: 5,
	}, nil
}

func (t *PhoneVerificationToken) IsExpired() bool {
	return time.Now().After(t.ExpiresAt)
}

func (t *PhoneVerificationToken) IsValid() bool {
	return !t.IsExpired() && t.Attempts < t.MaxAttempts
}

func (t *PhoneVerificationToken) IncrementAttempts() {
	t.Attempts++
}

func (t *PhoneVerificationToken) CanAttemptVerification() bool {
	return t.Attempts < t.MaxAttempts
}

func (t *PhoneVerificationToken) SetVerificationCode(code string) {
	t.VerificationCode = code
}

func (t *PhoneVerificationToken) VerifyCode(code string) bool {
	if !t.IsValid() {
		return false
	}
	return t.VerificationCode == code
}

func (t *PhoneVerificationToken) TimeRemaining() time.Duration {
	if t.IsExpired() {
		return 0
	}
	return time.Until(t.ExpiresAt)
}
