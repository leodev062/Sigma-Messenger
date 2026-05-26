package services

import (
	"context"
	"fmt"
	"os"
	"strconv"

	"sigma-server/ui/sigma/dto"
	"sigma-server/ui/sigma/telephony"

	"github.com/mercadopago/sdk-go/pkg/config"
	"github.com/mercadopago/sdk-go/pkg/payment"
)

type PaymentService struct {
	telephony   *telephony.TelephonyManager
	accessToken string
}

func NewPaymentService(telephony *telephony.TelephonyManager, accessToken string) *PaymentService {
	return &PaymentService{telephony: telephony, accessToken: accessToken}
}

func (s *PaymentService) CreatePayment(req dto.CreatePaymentRequest) (*dto.CreatePaymentResponse, error) {
	if s.accessToken == "" {
		return nil, fmt.Errorf("mercado pago access token is not configured")
	}
	cfg, err := config.New(s.accessToken)
	if err != nil {
		return nil, fmt.Errorf("failed to init mercado pago config: %w", err)
	}

	client := payment.NewClient(cfg)
	payReq := payment.Request{
		TransactionAmount: req.ValorTotal,
		Description:       req.Descricao,
		PaymentMethodID:   "pix",
		Payer: &payment.PayerRequest{
			Email:     req.EmailCliente,
			FirstName: req.NomeCliente,
		},
		Metadata: map[string]interface{}{
			"whatsapp_cliente": req.WhatsappCliente,
			"endereco_entrega": req.Endereco,
		},
	}

	res, err := client.Create(context.Background(), payReq)
	if err != nil {
		return nil, err
	}

	return &dto.CreatePaymentResponse{
		Status:       "SUCCESS",
		CopyPaste:    res.PointOfInteraction.TransactionData.QRCode,
		QRCodeBase64: res.PointOfInteraction.TransactionData.QRCodeBase64,
		PaymentID:    int64(res.ID),
	}, nil
}

func (s *PaymentService) CheckPaymentStatus(id string) (*dto.PaymentStatusResponse, error) {
	paymentID, err := strconv.Atoi(id)
	if err != nil {
		return nil, fmt.Errorf("invalid payment id")
	}

	if s.accessToken == "" {
		return nil, fmt.Errorf("mercado pago access token is not configured")
	}
	cfg, err := config.New(s.accessToken)
	if err != nil {
		return nil, fmt.Errorf("failed to init mercado pago config: %w", err)
	}
	client := payment.NewClient(cfg)

	res, err := client.Get(context.Background(), paymentID)
	if err != nil {
		return nil, fmt.Errorf("failed to check payment status: %w", err)
	}

	if res.Status == "approved" {
		numeroDaLoja := os.Getenv("STORE_PHONE_NUMBER")
		if numeroDaLoja == "" {
			numeroDaLoja = "5562999907170"
		}
		whatsappDoCliente := ""
		endereco := ""
		if res.Metadata != nil {
			if val, ok := res.Metadata["whatsapp_cliente"]; ok {
				whatsappDoCliente = fmt.Sprint(val)
			}
			if val, ok := res.Metadata["endereco_entrega"]; ok {
				endereco = fmt.Sprint(val)
			}
		}
		resumo := res.Description
		msgParaLoja := fmt.Sprintf("*🚨 NOVO PEDIDO PAGO NO PIX!*\n\n*Cliente:* %s\n*Pedido:* %s\n*Entrega:* %s\n\nPode começar a preparar! 🍔🚀", whatsappDoCliente, resumo, endereco)
		msgParaCliente := fmt.Sprintf("✅ *Pagamento Aprovado!*\n\nOlá! Seu Pix de R$ %.2f foi confirmado.\nJá começamos a preparar seu pedido (%s) e logo sairá para entrega em: *%s*.\n\nObrigado por pedir no Leozin Delivery! 🍔", res.TransactionAmount, resumo, endereco)

		go func() {
			_ = s.telephony.SendMessage(numeroDaLoja, msgParaLoja)
			_ = s.telephony.SendMessage(whatsappDoCliente, msgParaCliente)
		}()
	}

	return &dto.PaymentStatusResponse{Status: res.Status}, nil
}
