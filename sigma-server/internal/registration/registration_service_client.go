package registration

import (
	"context"
	"fmt"
	"time"
)

type RegistrationServiceClientConfig struct {
	Host             string
	Port             int
	CACertificate    string
	CollationKeySalt []byte
	Audience         string
}

type RegistrationServiceClient struct {
	config      *RegistrationServiceClientConfig
	credentials *IdentityTokenCredentials
}

func NewRegistrationServiceClient(config *RegistrationServiceClientConfig) (*RegistrationServiceClient, error) {
	credentials := NewIdentityTokenCredentials(config.Audience)
	if err := credentials.Start(); err != nil {
		return nil, fmt.Errorf("failed to initialize credentials: %w", err)
	}

	return &RegistrationServiceClient{
		config:      config,
		credentials: credentials,
	}, nil
}

func (c *RegistrationServiceClient) CreateRegistrationSession(
	ctx context.Context,
	phoneNumber string,
	sourceHost string,
	accountExistsWithPhoneNumber bool,
	clientMCC *string,
	clientMNC *string,
	timeout time.Duration,
) (*RegistrationServiceSession, error) {
	if timeout == 0 {
		timeout = 30 * time.Second
	}

	ctx, cancel := context.WithTimeout(ctx, timeout)
	defer cancel()

	session := &RegistrationServiceSession{
		SessionID: []byte(fmt.Sprintf("%s_%d", phoneNumber, time.Now().UnixNano())),
		E164:      phoneNumber,
		Metadata: map[string]interface{}{
			"created_at":     time.Now().Unix(),
			"source_host":    sourceHost,
			"account_exists": accountExistsWithPhoneNumber,
		},
	}

	return session, nil
}

func (c *RegistrationServiceClient) SendVerificationCode(
	ctx context.Context,
	sessionID []byte,
	transport MessageTransport,
	clientType ClientType,
	acceptLanguage *string,
	senderOverride *string,
	timeout time.Duration,
) (*RegistrationServiceSession, error) {
	if timeout == 0 {
		timeout = 30 * time.Second
	}

	ctx, cancel := context.WithTimeout(ctx, timeout)
	defer cancel()

	token, err := c.credentials.GetToken()
	if err != nil {
		return nil, fmt.Errorf("failed to get identity token: %w", err)
	}

	session := &RegistrationServiceSession{
		SessionID: sessionID,
		Metadata: map[string]interface{}{
			"token_used":  token,
			"transport":   transport.String(),
			"client_type": clientType.String(),
		},
	}

	return session, nil
}

func (c *RegistrationServiceClient) CheckVerificationCode(
	ctx context.Context,
	sessionID []byte,
	verificationCode string,
	timeout time.Duration,
) (*RegistrationServiceSession, error) {
	if timeout == 0 {
		timeout = 30 * time.Second
	}

	ctx, cancel := context.WithTimeout(ctx, timeout)
	defer cancel()

	if verificationCode == "" {
		return nil, NewRegistrationServiceException(&RegistrationServiceSession{SessionID: sessionID})
	}

	session := &RegistrationServiceSession{
		SessionID: sessionID,
		Metadata: map[string]interface{}{
			"verified_at": time.Now().Unix(),
		},
	}

	return session, nil
}

func (c *RegistrationServiceClient) GetSession(
	ctx context.Context,
	sessionID []byte,
	timeout time.Duration,
) (*RegistrationServiceSession, error) {
	if timeout == 0 {
		timeout = 30 * time.Second
	}

	ctx, cancel := context.WithTimeout(ctx, timeout)
	defer cancel()

	if len(sessionID) == 0 {
		return nil, ErrSessionNotFound
	}

	session := &RegistrationServiceSession{
		SessionID: sessionID,
	}

	return session, nil
}

func (c *RegistrationServiceClient) Close() {
	c.credentials.Stop()
}
