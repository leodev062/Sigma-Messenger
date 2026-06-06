package auth

import (
	"crypto/rand"
	"encoding/hex"
	"time"
)

type RegistrationLockStatus int

const (
	RegistrationLockStatusRequired RegistrationLockStatus = iota
	RegistrationLockStatusExpired
	RegistrationLockStatusAbsent
)

const (
	RegistrationLockExpirationDays = 7 * 24 * time.Hour
)

type StoredRegistrationLock struct {
	RegistrationLock     *string
	RegistrationLockSalt *string
	LastSeen             time.Time
}

func NewStoredRegistrationLock(lock, salt string) *StoredRegistrationLock {
	return &StoredRegistrationLock{
		RegistrationLock:     &lock,
		RegistrationLockSalt: &salt,
		LastSeen:             time.Now(),
	}
}

func (r *StoredRegistrationLock) HasLockAndSalt() bool {
	return r.RegistrationLock != nil && *r.RegistrationLock != "" &&
		r.RegistrationLockSalt != nil && *r.RegistrationLockSalt != ""
}

func (r *StoredRegistrationLock) IsPresent() bool {
	return r.HasLockAndSalt()
}

func (r *StoredRegistrationLock) TimeSinceLastSeen() time.Duration {
	return time.Since(r.LastSeen)
}

func (r *StoredRegistrationLock) GetStatus() RegistrationLockStatus {
	if !r.HasLockAndSalt() {
		return RegistrationLockStatusAbsent
	}

	if r.TimeSinceLastSeen() > RegistrationLockExpirationDays {
		return RegistrationLockStatusExpired
	}

	return RegistrationLockStatusRequired
}

func GenerateRegistrationLockSalt() (string, error) {
	salt := make([]byte, 16)
	_, err := rand.Read(salt)
	if err != nil {
		return "", err
	}
	return hex.EncodeToString(salt), nil
}

func (r *StoredRegistrationLock) UpdateLastSeen() {
	r.LastSeen = time.Now()
}
