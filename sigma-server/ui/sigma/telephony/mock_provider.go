package telephony

import "log"

type MockProvider struct{}

func NewMockProvider() *MockProvider {
	return &MockProvider{}
}

func (m *MockProvider) SendMessage(number, text string) error {
	log.Printf("📲 [MockProvider] Sending message to %s: %s", number, text)
	return nil
}
