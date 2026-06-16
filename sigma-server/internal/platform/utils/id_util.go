package utils

import (
	"fmt"
	"strings"

	"github.com/google/uuid"
)

func NewID(prefix string) string {
	raw := strings.ReplaceAll(uuid.New().String(), "-", "")
	return fmt.Sprintf("%s_%s", prefix, raw)
}

func NewUserID() string {
	return NewID("usr")
}

func NewBotID() string {
	return NewID("bot")
}

func NewGroupID() string {
	return NewID("grp")
}

func NewChannelID() string {
	return NewID("chn")
}

func NewDeviceID() string {
	return NewID("dev")
}

func NewConversationID() string {
	return NewID("cnv")
}

func NewMessageID() string {
	return NewID("msg")
}
