package dto

import "github.com/google/uuid"

type CreateChatRequest struct {
	UserID       string `json:"user_id"`
	Title        string `json:"title"`
	Type         string `json:"type"`
	TargetUserID string `json:"target_user_id"`
	IsPrivate    bool   `json:"is_private"`
}

type CreateChatResponse struct {
	ID          uuid.UUID `json:"id"`
	Type        string    `json:"type"`
	Title       string    `json:"title"`
	OwnerID     uuid.UUID `json:"owner_id"`
	MemberCount int       `json:"member_count"`
	IsPrivate   bool      `json:"is_private"`
}

type ChatSummaryResponse struct {
	ID          uuid.UUID `json:"id"`
	Type        string    `json:"type"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	Role        string    `json:"role"`
	IsMuted     bool      `json:"is_muted"`
	MemberCount int       `json:"member_count"`
}

type ChatMemberResponse struct {
	ID       uuid.UUID `json:"id"`
	Name     string    `json:"name"`
	Username string    `json:"username"`
	Phone    string    `json:"phone"`
	Avatar   string    `json:"avatar_url"`
	Bio      string    `json:"bio"`
	Role     string    `json:"role"`
}

type AddMembersRequest struct {
	UserIDs []string `json:"user_ids"`
}

type AddMembersResponse struct {
	Added          []string `json:"added"`
	AlreadyPresent []string `json:"already_present"`
	CurrentCount   int      `json:"current_count"`
	MaxMembers     int      `json:"max_members"`
	Message        string   `json:"message"`
}

type UpdateChatRequest struct {
	Title       *string `json:"title,omitempty"`
	Description *string `json:"description,omitempty"`
	AvatarURL   *string `json:"avatar_url,omitempty"`
}

type UpdateChatResponse struct {
	ID          uuid.UUID `json:"id"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	AvatarURL   string    `json:"avatar_url"`
	MemberCount int       `json:"member_count"`
}

type DeleteChatResponse struct {
	Deleted bool      `json:"deleted"`
	ChatID  uuid.UUID `json:"chat_id"`
	Message string    `json:"message"`
}

type RemoveMemberRequest struct {
	ChatID string `json:"chat_id"`
	UserID string `json:"user_id"`
}

type JoinGroupRequest struct {
	ChatID string `json:"chat_id"`
	UserID string `json:"user_id"`
}

type JoinGroupResponse struct {
	Joined bool `json:"joined"`
}

type RemoveMemberResponse struct {
	Removed  bool      `json:"removed"`
	MemberID uuid.UUID `json:"member_id"`
}
