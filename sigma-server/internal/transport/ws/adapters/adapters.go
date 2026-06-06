package adapters

import (
	"sigma-server/internal/repository/storage"
	"sigma-server/internal/service"
)

type MessageStore struct {
	*storage.MessageManager
}

type EventStore struct {
	*storage.PendingEventManager
}

type AccountKeys struct {
	*services.AccountService
}
