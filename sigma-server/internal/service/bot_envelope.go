package services

import (
	"time"

	"google.golang.org/protobuf/proto"

	sigmapb "sigma-server/proto"
)

func buildTextEnvelope(source, text string) ([]byte, error) {
	envelope := &sigmapb.Envelope{
		From:            source,
		CreatedAt:       time.Now().UnixMilli(),
		Payload:         []byte(text),
		DestinationType: sigmapb.EntityType_ENTITY_TYPE_USER, // Bots usually send to users
	}
	return proto.Marshal(envelope)
}
