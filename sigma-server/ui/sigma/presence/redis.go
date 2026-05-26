package presence

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"time"

	"sigma-server/ui/sigma/config"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
)

const (
	defaultChannel = "sigma:presence"
	defaultTTL     = 2 * time.Minute
)

type Event struct {
	Type      string `json:"type"`
	UserID    string `json:"user_id"`
	ServerID  string `json:"server_id"`
	Timestamp int64  `json:"timestamp"`
}

type Coordinator struct {
	client   redis.UniversalClient
	pubsub   *redis.PubSub
	channel  string
	serverID string
	logger   *log.Logger
	onEvent  func(Event)
}

func NewCoordinator(redisConfig config.RedisConfiguration, onEvent func(Event)) (*Coordinator, error) {
	cfg := redisConfig.Normalized()
	client := redis.NewUniversalClient(&redis.UniversalOptions{
		Addrs:      cfg.Addresses,
		Password:   cfg.Password,
		DB:         cfg.DB,
		MasterName: cfg.MasterName,
	})

	if _, err := client.Ping(context.Background()).Result(); err != nil {
		_ = client.Close()
		return nil, err
	}

	coordinator := &Coordinator{
		client:   client,
		channel:  defaultChannel,
		serverID: uuid.NewString(),
		logger:   log.Default(),
		onEvent:  onEvent,
	}

	coordinator.pubsub = client.Subscribe(context.Background(), coordinator.channel)
	go coordinator.listen()

	return coordinator, nil
}

func (c *Coordinator) Register(userID string) error {
	if c == nil || userID == "" {
		return nil
	}

	payload, err := json.Marshal(Event{
		Type:      "connected",
		UserID:    userID,
		ServerID:  c.serverID,
		Timestamp: time.Now().UnixMilli(),
	})
	if err != nil {
		return err
	}

	if err := c.client.Set(context.Background(), c.key(userID), c.serverID, defaultTTL).Err(); err != nil {
		return err
	}

	return c.client.Publish(context.Background(), c.channel, payload).Err()
}

func (c *Coordinator) Refresh(userID string) error {
	if c == nil || userID == "" {
		return nil
	}

	return c.client.Expire(context.Background(), c.key(userID), defaultTTL).Err()
}

func (c *Coordinator) Remove(userID string) error {
	if c == nil || userID == "" {
		return nil
	}

	if err := c.client.Del(context.Background(), c.key(userID)).Err(); err != nil {
		return err
	}

	payload, err := json.Marshal(Event{
		Type:      "disconnected",
		UserID:    userID,
		ServerID:  c.serverID,
		Timestamp: time.Now().UnixMilli(),
	})
	if err != nil {
		return err
	}

	return c.client.Publish(context.Background(), c.channel, payload).Err()
}

func (c *Coordinator) Close() error {
	if c == nil {
		return nil
	}

	if c.pubsub != nil {
		_ = c.pubsub.Close()
	}

	return c.client.Close()
}

func (c *Coordinator) listen() {
	if c == nil || c.pubsub == nil {
		return
	}

	ch := c.pubsub.Channel()
	for msg := range ch {
		if msg == nil {
			continue
		}

		var event Event
		if err := json.Unmarshal([]byte(msg.Payload), &event); err != nil {
			c.logger.Printf("presence: failed to decode event: %v", err)
			continue
		}

		if event.ServerID == c.serverID {
			continue
		}

		if c.onEvent != nil {
			c.onEvent(event)
		}
	}
}

func (c *Coordinator) key(userID string) string {
	return fmt.Sprintf("sigma:presence:%s", userID)
}
