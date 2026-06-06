package registration

import (
	"fmt"
	"sync"
	"time"
)

const (
	IdentityTokenLifetime      = 1 * time.Hour
	IdentityTokenRefreshBuffer = 10 * time.Minute
)

type IdentityTokenCredentials struct {
	mu            sync.RWMutex
	token         string
	lastError     error
	expiresAt     time.Time
	audience      string
	refreshTicker *time.Ticker
	stopChan      chan bool
	isInitialized bool
}

func NewIdentityTokenCredentials(audience string) *IdentityTokenCredentials {
	return &IdentityTokenCredentials{
		audience:      audience,
		stopChan:      make(chan bool),
		isInitialized: false,
	}
}

func (c *IdentityTokenCredentials) Start() error {
	if err := c.refreshIdentityToken(); err != nil {
		return fmt.Errorf("failed to initialize identity token: %w", err)
	}

	refreshInterval := IdentityTokenLifetime - IdentityTokenRefreshBuffer
	c.refreshTicker = time.NewTicker(refreshInterval)

	go func() {
		for {
			select {
			case <-c.refreshTicker.C:
				if err := c.refreshIdentityToken(); err != nil {
					fmt.Printf("failed to refresh identity token: %v\n", err)
				}
			case <-c.stopChan:
				c.refreshTicker.Stop()
				return
			}
		}
	}()

	c.isInitialized = true
	return nil
}

func (c *IdentityTokenCredentials) Stop() {
	if c.refreshTicker != nil {
		c.stopChan <- true
	}
}

func (c *IdentityTokenCredentials) GetToken() (string, error) {
	c.mu.RLock()
	defer c.mu.RUnlock()

	if c.lastError != nil {
		return "", c.lastError
	}

	if c.token == "" {
		return "", fmt.Errorf("identity token not available")
	}

	if time.Now().After(c.expiresAt) {
		return "", fmt.Errorf("identity token expired")
	}

	return c.token, nil
}

func (c *IdentityTokenCredentials) refreshIdentityToken() error {
	c.mu.Lock()
	defer c.mu.Unlock()

	token := generateMockToken(c.audience)
	c.token = token
	c.expiresAt = time.Now().Add(IdentityTokenLifetime)
	c.lastError = nil

	return nil
}

func (c *IdentityTokenCredentials) IsInitialized() bool {
	return c.isInitialized
}

func generateMockToken(audience string) string {
	return fmt.Sprintf("Bearer mock_token_for_%s_%d", audience, time.Now().Unix())
}
