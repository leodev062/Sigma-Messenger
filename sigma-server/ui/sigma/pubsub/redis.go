package pubsub

import (
	"context"
	"log"

	"sigma-server/ui/sigma/config"
	"sigma-server/ui/sigma/events"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
)

const defaultChannel = "sigma:events"

type RedisEventHub struct {
	client   redis.UniversalClient
	pubsub   *redis.PubSub
	channel  string
	serverID string
	onEvent  func(events.EventEnvelope)
	logger   *log.Logger
}

func NewRedisEventHub(redisConfig config.RedisConfiguration, onEvent func(events.EventEnvelope)) (*RedisEventHub, error) {
	cfg := redisConfig.Normalized()
	client := redis.NewUniversalClient(&redis.UniversalOptions{
		Addrs:      cfg.Addresses,
		Password:   cfg.Password,
		DB:         cfg.DB,
		MasterName: cfg.MasterName,
	})

	if _, err := client.Ping(context.Background()).Result(); err != nil {
		client.Close()
		return nil, err
	}

	hub := &RedisEventHub{
		client:   client,
		channel:  defaultChannel,
		serverID: uuid.NewString(),
		onEvent:  onEvent,
		logger:   log.Default(),
	}

	pubsub := client.Subscribe(context.Background(), hub.channel)
	hub.pubsub = pubsub

	go hub.listen()

	return hub, nil
}

func (h *RedisEventHub) Publish(ctx context.Context, event events.EventEnvelope) error {
	event.SourceServerID = h.serverID

	payload, err := event.Marshal()
	if err != nil {
		return err
	}

	return h.client.Publish(ctx, h.channel, payload).Err()
}

func (h *RedisEventHub) Close() error {
	if h.pubsub != nil {
		_ = h.pubsub.Close()
	}
	return h.client.Close()
}

func (h *RedisEventHub) listen() {
	ch := h.pubsub.Channel()
	for msg := range ch {
		if msg == nil {
			continue
		}

		event, err := events.DecodeEnvelope([]byte(msg.Payload))
		if err != nil {
			h.logger.Printf("pubsub: failed to decode event: %v", err)
			continue
		}

		if event.SourceServerID == h.serverID {
			continue
		}

		if h.onEvent != nil {
			h.onEvent(event)
		}
	}
}
