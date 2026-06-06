package botapi

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strings"
	"time"
)

const secretHeader = "X-Sigma-Bot-Api-Secret-Token"

type WebhookClient struct {
	httpClient *http.Client
}

func NewWebhookClient() *WebhookClient {
	return &WebhookClient{
		httpClient: &http.Client{Timeout: 10 * time.Second},
	}
}

func (c *WebhookClient) PostUpdate(ctx context.Context, url, secretToken string, update any) error {
	if c == nil || strings.TrimSpace(url) == "" {
		return fmt.Errorf("webhook url is required")
	}

	body, err := json.Marshal(update)
	if err != nil {
		return err
	}

	req, err := http.NewRequestWithContext(ctx, http.MethodPost, url, bytes.NewReader(body))
	if err != nil {
		return err
	}
	req.Header.Set("Content-Type", "application/json")
	if secretToken != "" {
		req.Header.Set(secretHeader, secretToken)
	}

	resp, err := c.httpClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode < 200 || resp.StatusCode >= 300 {
		snippet, _ := io.ReadAll(io.LimitReader(resp.Body, 512))
		return fmt.Errorf("webhook returned status %d: %s", resp.StatusCode, strings.TrimSpace(string(snippet)))
	}
	return nil
}
