package storage

import (
	"sigma-server/ui/sigma/entities"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type MessageManager struct {
	store *BaseStore[entities.PendingMessage]
}

func NewMessageManager(db *gorm.DB) *MessageManager {
	return &MessageManager{store: NewBaseStore[entities.PendingMessage](db)}
}

func (m *MessageManager) FindPendingByAccountID(accountID uuid.UUID) ([]entities.PendingMessage, error) {
	return m.store.FindWhere("timestamp asc", "destination_id = ?", accountID)
}

func (m *MessageManager) Delete(id int) error {
	return m.store.DeleteByID(id)
}

func (m *MessageManager) DeleteByMessageID(messageID uuid.UUID) error {
	return m.store.DeleteWhere("message_id = ?", messageID)
}

func (m *MessageManager) Save(message *entities.PendingMessage) error {
	return m.store.Create(message)
}
