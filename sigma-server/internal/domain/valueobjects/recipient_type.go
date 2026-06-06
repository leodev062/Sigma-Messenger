package valueobjects

import "strings"

// RecipientType matches PostgreSQL enum recipient_type / chat_type.
type RecipientType string

const (
	RecipientIndividual RecipientType = "individual"
	RecipientGroup      RecipientType = "group"
	RecipientChannel    RecipientType = "channel"
	RecipientBot        RecipientType = "bot"
)

func ParseRecipientType(raw string) (RecipientType, bool) {
	switch RecipientType(strings.ToLower(strings.TrimSpace(raw))) {
	case RecipientIndividual, RecipientGroup, RecipientChannel, RecipientBot:
		return RecipientType(strings.ToLower(strings.TrimSpace(raw))), true
	default:
		return "", false
	}
}

func (t RecipientType) String() string {
	return string(t)
}

func (t RecipientType) IsBroadcast() bool {
	return t == RecipientGroup || t == RecipientChannel
}

func (t RecipientType) IsBot() bool {
	return t == RecipientBot
}
