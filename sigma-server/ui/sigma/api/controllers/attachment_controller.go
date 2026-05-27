/*
Sigma Server Attachment Controller

Este arquivo faz parte da arquitetura de anexos do projeto Sigma Server.
A lógica estrutural e a arquitetura de anexos pertencem ao projeto Sigma Server.
É permitida a cópia, modificação e distribuição deste código,
contanto que os créditos originais e os direitos autorais sejam mantidos
neste cabeçalho.
*/

package controllers

import (
	"net/http"

	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
)

type AttachmentController struct{}

type requestUploadRequest struct {
	FileSize int64 `json:"file_size"`
}

type requestUploadResponse struct {
	AttachmentID string `json:"attachment_id"`
	UploadURL    string `json:"upload_url"`
	DownloadURL  string `json:"download_url"`
}

func NewAttachmentController() *AttachmentController {
	return &AttachmentController{}
}

func (c *AttachmentController) RegisterRoutes(g *echo.Group) {
	attachments := g.Group("/attachments")
	attachments.POST("/request-upload", c.RequestUpload)
	attachments.POST("/upload", c.Upload)
	attachments.GET("/:id", c.Download)
}

// NOTE: Attachment endpoints are blind to the attachment contents.
// The server must only handle encrypted bytes and never perform decryption.
func (c *AttachmentController) RequestUpload(ctx echo.Context) error {
	var req requestUploadRequest
	if err := ctx.Bind(&req); err != nil {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "invalid request payload"})
	}

	if req.FileSize <= 0 {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "file_size must be greater than zero"})
	}

	attachmentID := uuid.New().String()

	// Neste ponto, um storage service futuro deverá armazenar o metadado do upload.
	// O servidor não deve inspecionar ou descriptografar os bytes do anexo.

	response := requestUploadResponse{
		AttachmentID: attachmentID,
		UploadURL:    "/api/v1/attachments/upload?attachment_id=" + attachmentID,
		DownloadURL:  "/api/v1/attachments/" + attachmentID,
	}

	return ctx.JSON(http.StatusOK, response)
}

func (c *AttachmentController) Upload(ctx echo.Context) error {
	attachmentID := ctx.QueryParam("attachment_id")
	if attachmentID == "" {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "attachment_id query parameter is required"})
	}

	fileHeader, err := ctx.FormFile("file")
	if err != nil {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "file field is required"})
	}

	src, err := fileHeader.Open()
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "failed to open uploaded file"})
	}
	defer src.Close()

	// TODO: Ler os bytes do arquivo criptografado e armazená-los em S3, MinIO ou disco local.
	// Importante: o servidor deve armazenar apenas o payload cifrado. Não tente descriptografar.
	// Exemplo futuro:
	//  encryptedBytes, err := io.ReadAll(src)
	//  if err != nil { ... }
	//  storage.SaveAttachment(attachmentID, encryptedBytes)

	return ctx.JSON(http.StatusOK, map[string]string{"status": "upload accepted", "attachment_id": attachmentID})
}

func (c *AttachmentController) Download(ctx echo.Context) error {
	attachmentID := ctx.Param("id")
	if attachmentID == "" {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "attachment id is required"})
	}

	// TODO: Recuperar os bytes brutos do storage e devolvê-los como stream.
	// Exemplo futuro:
	//  encryptedBytes, err := storage.GetAttachment(attachmentID)
	//  if err != nil { ... }
	//  return ctx.Blob(http.StatusOK, "application/octet-stream", encryptedBytes)

	return ctx.JSON(http.StatusOK, map[string]string{"status": "download endpoint placeholder", "attachment_id": attachmentID})
}
