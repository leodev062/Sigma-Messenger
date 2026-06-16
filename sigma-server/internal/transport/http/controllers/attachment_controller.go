/*
Sigma Server Attachment Controller

Este arquivo faz parte da arquitetura de anexos do projeto Sigma Server.
*/

package controllers

import (
	"net/http"

	"sigma-server/internal/platform/utils"

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

func (c *AttachmentController) RegisterRoutes(g *echo.Group, jwt echo.MiddlewareFunc) {
	attachments := g.Group("/attachments", jwt)
	attachments.POST("/request-upload", c.RequestUpload)
	attachments.POST("/upload", c.Upload)
	attachments.GET("/:id", c.Download)
}

func (c *AttachmentController) RequestUpload(ctx echo.Context) error {
	var req requestUploadRequest
	if err := ctx.Bind(&req); err != nil {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "invalid request payload"})
	}

	if req.FileSize <= 0 {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "file_size must be greater than zero"})
	}

	attachmentID := utils.NewID("att")

	response := requestUploadResponse{
		AttachmentID: attachmentID,
		UploadURL:    "/v1/attachments/upload?attachment_id=" + attachmentID,
		DownloadURL:  "/v1/attachments/" + attachmentID,
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

	return ctx.JSON(http.StatusOK, map[string]string{"status": "upload accepted", "attachment_id": attachmentID})
}

func (c *AttachmentController) Download(ctx echo.Context) error {
	attachmentID := ctx.Param("id")
	if attachmentID == "" {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "attachment id is required"})
	}

	return ctx.JSON(http.StatusOK, map[string]string{"status": "download endpoint placeholder", "attachment_id": attachmentID})
}
