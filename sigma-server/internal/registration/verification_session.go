package registration

import (
	"time"
)

type VerificationSessionInformation string

const (
	VerificationSessionInformationPushChallenge VerificationSessionInformation = "pushChallenge"
	VerificationSessionInformationCaptcha       VerificationSessionInformation = "captcha"
)

type VerificationSession struct {
	SessionID               string
	E164                    string
	PushChallenge           *string
	CarrierData             any
	RequestedInformation    []VerificationSessionInformation
	SubmittedInformation    []VerificationSessionInformation
	SMSSenderOverride       *string
	VoiceSenderOverride     *string
	AllowedToRequestCode    bool
	CreatedTimestamp        int64
	UpdatedTimestamp        int64
	RemoteExpirationSeconds int64
}

func (v *VerificationSession) GetExpirationEpochSeconds() int64 {
	return time.UnixMilli(v.UpdatedTimestamp).Add(time.Duration(v.RemoteExpirationSeconds) * time.Second).Unix()
}

func (v *VerificationSession) IsExpired() bool {
	return v.GetExpirationEpochSeconds() < time.Now().Unix()
}

func NewVerificationSession(sessionID string, phoneNumber string, remoteExpirationSeconds int64) *VerificationSession {
	now := time.Now().UnixMilli()
	return &VerificationSession{
		SessionID:               sessionID,
		E164:                    phoneNumber,
		RequestedInformation:    make([]VerificationSessionInformation, 0),
		SubmittedInformation:    make([]VerificationSessionInformation, 0),
		AllowedToRequestCode:    false,
		CreatedTimestamp:        now,
		UpdatedTimestamp:        now,
		RemoteExpirationSeconds: remoteExpirationSeconds,
	}
}

func (v *VerificationSession) WithPushChallenge(challenge string) *VerificationSession {
	v.PushChallenge = &challenge
	return v
}

func (v *VerificationSession) WithCarrierData(carrierData any) *VerificationSession {
	v.CarrierData = carrierData
	return v
}

func (v *VerificationSession) AddRequestedInformation(info VerificationSessionInformation) *VerificationSession {
	v.RequestedInformation = append(v.RequestedInformation, info)
	return v
}

func (v *VerificationSession) AddSubmittedInformation(info VerificationSessionInformation) *VerificationSession {
	v.SubmittedInformation = append(v.SubmittedInformation, info)
	return v
}

func (v *VerificationSession) SetAllowedToRequestCode(allowed bool) *VerificationSession {
	v.AllowedToRequestCode = allowed
	v.UpdatedTimestamp = time.Now().UnixMilli()
	return v
}
