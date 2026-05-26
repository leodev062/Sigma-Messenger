package telephony

import "log"

type TwilioProvider struct {
	APIKey string
}

func NewTwilioProvider(apiKey string) *TwilioProvider {
	return &TwilioProvider{APIKey: apiKey}
}

func (t *TwilioProvider) SendMessage(number, text string) error {
	log.Printf("📲 [TwilioProvider] Preparing message to %s with API key length=%d", number, len(t.APIKey))
	// TODO: implement real Twilio / SMS provider call here.
	// Example: http.Post("https://api.twilio.com/2010-04-01/Accounts/...", ...)
	return nil
}
