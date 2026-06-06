package registration

import (
	"encoding/json"
)

type MessageTransport int

const (
	MessageTransportUnknown MessageTransport = iota
	MessageTransportSMS
	MessageTransportVoice
)

func (m MessageTransport) String() string {
	switch m {
	case MessageTransportSMS:
		return "SMS"
	case MessageTransportVoice:
		return "VOICE"
	default:
		return "UNKNOWN"
	}
}

func (m MessageTransport) MarshalJSON() ([]byte, error) {
	return json.Marshal(m.String())
}

func (m *MessageTransport) UnmarshalJSON(data []byte) error {
	var s string
	if err := json.Unmarshal(data, &s); err != nil {
		return err
	}

	switch s {
	case "SMS":
		*m = MessageTransportSMS
	case "VOICE":
		*m = MessageTransportVoice
	default:
		*m = MessageTransportUnknown
	}
	return nil
}
