package services

import "errors"

type ChatAPIError struct {
	Status  int
	Code    string
	Message string
}

func (e *ChatAPIError) Error() string {
	return e.Message
}

func NewChatAPIError(status int, code string, message string) *ChatAPIError {
	return &ChatAPIError{Status: status, Code: code, Message: message}
}

var (
	ErrInvalidReaction  = errors.New("invalid reaction")
	ErrReactionNotFound = errors.New("reaction not found")
)
