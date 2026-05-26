package services

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
