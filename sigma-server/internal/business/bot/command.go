package bot

import (
	"strings"
)

const (
	CommandStart  = "/start"
	CommandNewBot = "/newbot"
	CommandMyBots = "/mybots"
	CommandHelp   = "/help"
)

type Command struct {
	Name string
	Args []string
}

func ParseCommand(text string) *Command {
	text = strings.TrimSpace(text)
	if text == "" || !strings.HasPrefix(text, "/") {
		return nil
	}

	parts := strings.Fields(text)
	if len(parts) == 0 {
		return nil
	}

	name := strings.ToLower(parts[0])
	if at := strings.Index(name, "@"); at > 0 {
		name = name[:at]
	}

	cmd := &Command{Name: name}
	if len(parts) > 1 {
		cmd.Args = parts[1:]
	}
	return cmd
}

func (c *Command) ArgString() string {
	if c == nil || len(c.Args) == 0 {
		return ""
	}
	return strings.Join(c.Args, " ")
}

func IsStart(cmd *Command) bool {
	return cmd != nil && cmd.Name == CommandStart
}
