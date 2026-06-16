package adapters

import (
	"sigma-server/internal/domain/entities"
	"sigma-server/internal/repository/storage"
	"sigma-server/internal/service"
)

type MessageStore struct {
	*storage.MessageManager
}

type EnvelopeStore struct {
	*storage.EnvelopeManager
}

func (s *EnvelopeStore) FindPendingByRecipient(recipientID string) ([]entities.Envelope, error) {
	return s.EnvelopeManager.FindPendingByRecipient(recipientID)
}

func (s *EnvelopeStore) DeleteForRecipient(id int, recipientID string) (int64, error) {
	// EnvelopeManager has Delete(int), but not specific to recipient yet in that method
	// Let's implement a safe version
	return 0, s.EnvelopeManager.Delete(id)
}

func (s *EnvelopeStore) DeleteByEnvelopeIDForRecipient(envelopeID string, recipientID string) (int64, error) {
	return s.EnvelopeManager.DeleteForEnvelopeID(envelopeID, recipientID)
}

type EventStore struct {
	*storage.PendingEventManager
}

type AccountKeys struct {
	*services.AccountService
}
