package bot

import (
	"fmt"
	"strings"
)

// Reply is a plaintext bot response delivered back to the user.
type Reply struct {
	Text string
}

type Handler struct {
	displayName string
	isFather    bool
}

func NewHandler(displayName string, isFather bool) *Handler {
	return &Handler{displayName: strings.TrimSpace(displayName), isFather: isFather}
}

func (h *Handler) HandleStart() *Reply {
	name := h.displayName
	if name == "" {
		name = "bot"
	}
	return &Reply{Text: fmt.Sprintf("Olá! Eu sou %s.\n\nEnvie /help para ver os comandos disponíveis.", name)}
}

func (h *Handler) HandleHelp() *Reply {
	if h.isFather {
		return &Reply{Text: strings.TrimSpace(`
Comandos do BotFather:
/start — reiniciar
/newbot <nome> — criar um novo bot
/mybots — listar seus bots
/help — esta mensagem
`)}
	}
	return &Reply{Text: strings.TrimSpace(`
Comandos:
/start — reiniciar conversa
/help — esta mensagem
`)}
}

func (h *Handler) HandleCommand(cmd *Command) *Reply {
	if cmd == nil {
		return nil
	}
	switch cmd.Name {
	case CommandStart:
		return h.HandleStart()
	case CommandHelp:
		return h.HandleHelp()
	default:
		if h.isFather {
			return nil
		}
		return &Reply{Text: "Comando desconhecido. Envie /help."}
	}
}
