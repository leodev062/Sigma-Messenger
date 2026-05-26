package dto

type RequestCodeRequest struct {
	Phone string `json:"phone"`
}

type LoginRequest struct {
	Phone string `json:"phone"`
	Code  string `json:"code"`
}

type LoginResponse struct {
	Token string      `json:"token"`
	User  interface{} `json:"user"`
}
