package services

import (
	"time"

	"google.golang.org/protobuf/proto"

	sigmapb "sigma-server/proto"
)

func buildTextEnvelope(source, text string) ([]byte, error) {
	envelope := &sigmapb.Envelope{
		Type:      sigmapb.Envelope_CIPHERTEXT,
		Source:    source,
		Timestamp: uint64(time.Now().UnixMilli()),
		Content:   []byte(text),
	}
	return proto.Marshal(envelope)
}
