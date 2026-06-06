package storage

import (
	"fmt"
	"strings"
)

const (
	ChatTypeIndividual = "individual"
	ChatTypeGroup      = "group"
	ChatTypeChannel    = "channel"
	ChatTypeBot        = "bot"
	RoleOwner          = "owner"
	RoleAdmin          = "admin"
	RoleMember         = "member"
)

func EffectiveMemberLimit(chatType string, verificationType string) int {
	chatType = strings.ToLower(strings.TrimSpace(chatType))
	verificationType = strings.ToLower(strings.TrimSpace(verificationType))

	switch chatType {
	case ChatTypeGroup:
		switch verificationType {
		case "verified", "business", "premium":
			return 1000
		default:
			return 250
		}
	case ChatTypeChannel:
		switch verificationType {
		case "verified":
			return 5000
		case "business", "premium":
			return 3000
		default:
			return 1000
		}
	default:
		return 0
	}
}

func CanManageChat(role string) bool {
	switch strings.ToLower(strings.TrimSpace(role)) {
	case RoleOwner, RoleAdmin:
		return true
	default:
		return false
	}
}

func CanDeleteChat(role string) bool {
	return strings.EqualFold(strings.TrimSpace(role), RoleOwner)
}

func FormatMemberLimitReachedMessage(chatType string, limit int) string {
	description := strings.ToLower(strings.TrimSpace(chatType))
	switch description {
	case ChatTypeGroup:
		description = "grupo"
	case ChatTypeChannel:
		description = "canal"
	default:
		description = chatType
	}
	return fmt.Sprintf("o %s já atingiu o limite máximo de %d membros", description, limit)
}
