package dto

type CreatePaymentRequest struct {
	Descricao       string  `json:"descricao"`
	ValorTotal      float64 `json:"valorTotal"`
	EmailCliente    string  `json:"emailCliente"`
	NomeCliente     string  `json:"nomeCliente"`
	Endereco        string  `json:"endereco"`
	WhatsappCliente string  `json:"whatsappCliente"`
}

type CreatePaymentResponse struct {
	Status       string `json:"status"`
	CopyPaste    string `json:"copiaECola"`
	QRCodeBase64 string `json:"qrCodeBase64"`
	PaymentID    int64  `json:"paymentId"`
}

type PaymentStatusResponse struct {
	Status string `json:"status"`
}
