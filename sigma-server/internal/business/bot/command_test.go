package bot

import "testing"

func TestParseCommandStart(t *testing.T) {
	cmd := ParseCommand("/start")
	if cmd == nil || cmd.Name != CommandStart {
		t.Fatalf("unexpected command: %+v", cmd)
	}
}

func TestParseCommandNewBotWithArgs(t *testing.T) {
	cmd := ParseCommand("/newbot Meu Assistente")
	if cmd == nil || cmd.Name != CommandNewBot {
		t.Fatalf("unexpected command: %+v", cmd)
	}
	if cmd.ArgString() != "Meu Assistente" {
		t.Fatalf("unexpected args: %q", cmd.ArgString())
	}
}
