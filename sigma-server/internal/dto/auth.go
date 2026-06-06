package dto

type RequestCodeRequest struct {
	Phone string `json:"phone"`
}

type LoginRequest struct {
	Phone         string `json:"phone"`
	Code          string `json:"code"`
	DeviceID      string `json:"device_id"`
	DeviceName    string `json:"device_name"`
	Platform      string `json:"platform"`
	ClientVersion string `json:"client_version"`
}

type LoginResponse struct {
	Token string      `json:"token"`
	User  interface{} `json:"user"`
}
