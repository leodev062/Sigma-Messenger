package registration

import (
	"encoding/json"
	"errors"
	"fmt"
)

type RegistrationServiceSession struct {
	SessionID []byte `json:"session_id"`
	E164      string `json:"e164"`
	Metadata  any    `json:"metadata"`
}

type RegistrationServiceException struct {
	Session *RegistrationServiceSession
	Message string
}

func (e *RegistrationServiceException) Error() string {
	if e.Message != "" {
		return e.Message
	}
	return "registration service error"
}

func NewRegistrationServiceException(session *RegistrationServiceSession) *RegistrationServiceException {
	return &RegistrationServiceException{Session: session, Message: "registration service error"}
}

type TransportNotAllowedException struct {
	*RegistrationServiceException
}

func NewTransportNotAllowedException(session *RegistrationServiceSession) *TransportNotAllowedException {
	return &TransportNotAllowedException{
		RegistrationServiceException: &RegistrationServiceException{
			Session: session,
			Message: "transport not allowed",
		},
	}
}

func (e *TransportNotAllowedException) Error() string {
	return "transport not allowed for destination number"
}

type RegistrationServiceSenderReason string

const (
	SenderReasonProviderUnavailable RegistrationServiceSenderReason = "providerUnavailable"
	SenderReasonProviderRejected    RegistrationServiceSenderReason = "providerRejected"
	SenderReasonIllegalArgument     RegistrationServiceSenderReason = "illegalArgument"
)

func (r RegistrationServiceSenderReason) MarshalJSON() ([]byte, error) {
	return json.Marshal(string(r))
}

func (r *RegistrationServiceSenderReason) UnmarshalJSON(data []byte) error {
	var s string
	if err := json.Unmarshal(data, &s); err != nil {
		return err
	}

	switch s {
	case "providerUnavailable":
		*r = SenderReasonProviderUnavailable
	case "providerRejected":
		*r = SenderReasonProviderRejected
	case "illegalArgument":
		*r = SenderReasonIllegalArgument
	}
	return nil
}

type RegistrationServiceSenderException struct {
	Reason    RegistrationServiceSenderReason
	Permanent bool
}

func (e *RegistrationServiceSenderException) Error() string {
	return fmt.Sprintf("sender error: %s (permanent: %v)", e.Reason, e.Permanent)
}

func NewSenderExceptionIllegalArgument(permanent bool) *RegistrationServiceSenderException {
	return &RegistrationServiceSenderException{
		Reason:    SenderReasonIllegalArgument,
		Permanent: permanent,
	}
}

func NewSenderExceptionRejected(permanent bool) *RegistrationServiceSenderException {
	return &RegistrationServiceSenderException{
		Reason:    SenderReasonProviderRejected,
		Permanent: permanent,
	}
}

func NewSenderExceptionUnknown(permanent bool) *RegistrationServiceSenderException {
	return &RegistrationServiceSenderException{
		Reason:    SenderReasonProviderUnavailable,
		Permanent: permanent,
	}
}

type RegistrationFraudException struct {
	Cause *RegistrationServiceSenderException
}

func (e *RegistrationFraudException) Error() string {
	if e.Cause != nil {
		return fmt.Sprintf("registration fraud detected: %v", e.Cause)
	}
	return "registration fraud detected"
}

func (e *RegistrationFraudException) Unwrap() error {
	return e.Cause
}

func NewRegistrationFraudException(cause *RegistrationServiceSenderException) *RegistrationFraudException {
	return &RegistrationFraudException{Cause: cause}
}

var (
	ErrSessionNotFound      = errors.New("registration session not found")
	ErrSessionAlreadyExists = errors.New("registration session already exists")
	ErrRateLimited          = errors.New("rate limit exceeded")
	ErrInvalidPhoneNumber   = errors.New("invalid phone number")
)
