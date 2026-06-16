package valueobjects

import "strings"

// RecipientType matches PostgreSQL enum recipient_type / chat_type.
// Alinhado com EntityType do Protobuf (EIRA).
type RecipientType string

const (
	RecipientIndividual RecipientType = "USER"
	RecipientGroup      RecipientType = "GROUP"
	RecipientChannel    RecipientType = "CHANNEL"
	RecipientBot        RecipientType = "BOT"
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
