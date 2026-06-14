package adapters

import (
	"sigma-server/internal/repository/storage"
	"sigma-server/internal/service"
)

type MessageStore struct {
	*storage.MessageManager
}

type EnvelopeStore struct {
	*storage.EnvelopeManager
}

type EventStore struct {
	*storage.PendingEventManager
}

type AccountKeys struct {
	*services.AccountService
}
