// Exemplo de bot externo (estilo Telegram): responde /clima <cidade> via long polling.
//
// 1. Crie o bot no app com BotFather (/newbot) e copie o token.
// 2. export SIGMA_BOT_TOKEN=seu_token
// 3. go run ./examples/weather-bot
package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"strings"
	"time"
)

const defaultAPI = "http://localhost:3000"

type apiResponse struct {
	OK     bool            `json:"ok"`
	Result json.RawMessage `json:"result"`
}

type update struct {
	UpdateID int64 `json:"update_id"`
	Message  *struct {
		Chat struct {
			ID string `json:"id"`
		} `json:"chat"`
		Text string `json:"text"`
	} `json:"message"`
}

func main() {
	token := os.Getenv("SIGMA_BOT_TOKEN")
	if token == "" {
		log.Fatal("defina SIGMA_BOT_TOKEN")
	}
	base := os.Getenv("SIGMA_API_BASE")
	if base == "" {
		base = defaultAPI
	}
	base = strings.TrimRight(base, "/") + "/bot/" + token

	log.Printf("bot conectado em %s", base)

	var offset int64
	for {
		updates, err := getUpdates(base, offset, 25)
		if err != nil {
			log.Printf("getUpdates: %v", err)
			time.Sleep(2 * time.Second)
			continue
		}
		for _, u := range updates {
			offset = u.UpdateID + 1
			if u.Message == nil || u.Message.Text == "" {
				continue
			}
			reply := handleCommand(u.Message.Text)
			if reply == "" {
				continue
			}
			if err := sendMessage(base, u.Message.Chat.ID, reply); err != nil {
				log.Printf("sendMessage: %v", err)
			}
		}
	}
}

func handleCommand(text string) string {
	text = strings.TrimSpace(text)
	switch {
	case text == "/start":
		return "Olá! Envie /clima São Paulo para uma previsão de exemplo."
	case strings.HasPrefix(text, "/clima"):
		city := strings.TrimSpace(strings.TrimPrefix(text, "/clima"))
		if city == "" {
			return "Uso: /clima <cidade>"
		}
		return fmt.Sprintf("☀️ %s: 28°C, céu limpo (exemplo — conecte uma API meteorológica real).", city)
	default:
		return ""
	}
}

func getUpdates(base string, offset int64, timeout int) ([]update, error) {
	url := fmt.Sprintf("%s/getUpdates?offset=%d&timeout=%d", base, offset, timeout)
	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var envelope apiResponse
	if err := json.NewDecoder(resp.Body).Decode(&envelope); err != nil {
		return nil, err
	}
	if !envelope.OK {
		return nil, fmt.Errorf("api error")
	}
	var updates []update
	if err := json.Unmarshal(envelope.Result, &updates); err != nil {
		return nil, err
	}
	return updates, nil
}

func sendMessage(base, chatID, text string) error {
	body, _ := json.Marshal(map[string]string{
		"chat_id": chatID,
		"text":    text,
	})
	resp, err := http.Post(base+"/sendMessage", "application/json", bytes.NewReader(body))
	if err != nil {
		return err
	}
	defer resp.Body.Close()
	if resp.StatusCode >= 300 {
		b, _ := io.ReadAll(resp.Body)
		return fmt.Errorf("status %d: %s", resp.StatusCode, b)
	}
	return nil
}
