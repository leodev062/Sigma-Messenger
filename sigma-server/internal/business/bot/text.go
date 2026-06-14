package bot

import (
	"strings"
	"unicode/utf8"

	"google.golang.org/protobuf/proto"

	sigmapb "sigma-server/proto"
)

// ExtractCommandText tries to read a slash-command from envelope or raw payload.
func ExtractCommandText(payload []byte) string {
	if len(payload) == 0 {
		return ""
	}

	if text := strings.TrimSpace(string(payload)); strings.HasPrefix(text, "/") && utf8.ValidString(text) {
		return text
	}

	var envelope sigmapb.Envelope
	if err := proto.Unmarshal(payload, &envelope); err != nil {
		return ""
	}

	content := strings.TrimSpace(string(envelope.GetPayload()))
	if strings.HasPrefix(content, "/") && utf8.ValidString(content) {
		return content
	}
	return ""
}
