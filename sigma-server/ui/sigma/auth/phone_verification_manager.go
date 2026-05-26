package auth

import (
	"crypto/rand"
	"fmt"
	"log"
	"math/big"
	"sync"

	"sigma-server/ui/sigma/telephony"
)

type PhoneVerificationManager struct {
	telephony telephony.TelephonyProvider
	codes     map[string]string
	lock      sync.RWMutex
}

func NewPhoneVerificationManager(telephony telephony.TelephonyProvider) *PhoneVerificationManager {
	return &PhoneVerificationManager{
		telephony: telephony,
		codes:     make(map[string]string),
	}
}

func (p *PhoneVerificationManager) GenerateAndSendCode(phone string) error {
	if phone == "" {
		return fmt.Errorf("phone is required")
	}

	code, err := generateCode()
	if err != nil {
		return err
	}

	p.lock.Lock()
	p.codes[phone] = code
	p.lock.Unlock()

	message := fmt.Sprintf("Seu código de verificação é: %s", code)
	log.Printf("🔐 [PhoneVerificationManager] Enviando OTP para %s", phone)
	return p.telephony.SendMessage(phone, message)
}

func (p *PhoneVerificationManager) VerifyCode(phone, code string) bool {
	if phone == "" || code == "" {
		return false
	}

	p.lock.RLock()
	expected, ok := p.codes[phone]
	p.lock.RUnlock()

	if !ok || expected != code {
		return false
	}

	p.lock.Lock()
	delete(p.codes, phone)
	p.lock.Unlock()

	return true
}

func generateCode() (string, error) {
	var digits [6]byte
	for i := 0; i < len(digits); i++ {
		n, err := rand.Int(rand.Reader, bigInt10())
		if err != nil {
			return "", err
		}
		digits[i] = byte('0' + n.Int64())
	}

	return string(digits[:]), nil
}

func bigInt10() *big.Int {
	return big.NewInt(10)
}
