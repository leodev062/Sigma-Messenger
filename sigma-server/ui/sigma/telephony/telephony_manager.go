package telephony

import (
	"fmt"
	"strings"

	"sigma-server/ui/sigma/config"
)

type TelephonyManager struct {
	provider TelephonyProvider
}

func NewTelephonyManager(cfg config.TelephonyConfiguration) *TelephonyManager {
	provider := selectProvider(cfg)
	return &TelephonyManager{provider: provider}
}

func selectProvider(cfg config.TelephonyConfiguration) TelephonyProvider {
	switch strings.ToLower(strings.TrimSpace(cfg.Provider)) {
	case "twilio", "real", "prod", "production":
		return NewTwilioProvider(cfg.APIKey)
	default:
		return NewMockProvider()
	}
}

func (t *TelephonyManager) SendMessage(number, text string) error {
	if t == nil || t.provider == nil {
		return fmt.Errorf("telephony provider is not configured")
	}

	return t.provider.SendMessage(number, text)
}
