package bot

import (
	"fmt"
	"strings"
)

// Father handles BotFather-specific commands.
type Father struct {
	handler *Handler
}

func NewFather() *Father {
	return &Father{handler: NewHandler("BotFather", true)}
}

func (f *Father) HandleCommand(cmd *Command, ownedBots []OwnedBotSummary) *Reply {
	if cmd == nil {
		return nil
	}

	switch cmd.Name {
	case CommandStart:
		return &Reply{Text: strings.TrimSpace(`
Bem-vindo ao BotFather!

Use /newbot <nome> para criar um bot.
Use /mybots para ver seus bots.
`)}
	case CommandHelp:
		return f.handler.HandleHelp()
	case CommandNewBot:
		name := strings.TrimSpace(cmd.ArgString())
		if name == "" {
			return &Reply{Text: "Informe o nome: /newbot MeuBot"}
		}
		return &Reply{Text: fmt.Sprintf("Criando bot \"%s\"…", name)}
	case CommandMyBots:
		if len(ownedBots) == 0 {
			return &Reply{Text: "Você ainda não criou nenhum bot. Use /newbot <nome>."}
		}
		var b strings.Builder
		b.WriteString("Seus bots:\n")
		for _, bot := range ownedBots {
			line := bot.DisplayName
			if bot.Username != "" {
				line += " (@" + bot.Username + ")"
			}
			b.WriteString("- " + line + "\n")
		}
		return &Reply{Text: strings.TrimSpace(b.String())}
	default:
		return &Reply{Text: "Comando desconhecido. Envie /help."}
	}
}

type OwnedBotSummary struct {
	ID          string
	DisplayName string
	Username    string
}
