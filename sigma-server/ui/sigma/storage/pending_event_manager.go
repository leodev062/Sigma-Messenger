package storage

import (
	"sigma-server/ui/sigma/entities"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type PendingEventManager struct {
	store *BaseStore[entities.PendingEvent]
}

func NewPendingEventManager(db *gorm.DB) *PendingEventManager {
	return &PendingEventManager{store: NewBaseStore[entities.PendingEvent](db)}
}

func (m *PendingEventManager) FindPendingByAccountID(accountID uuid.UUID) ([]entities.PendingEvent, error) {
	return m.store.FindWhere("created_at asc", "target_user_id = ?", accountID)
}

func (m *PendingEventManager) Delete(id int) error {
	return m.store.DeleteByID(id)
}

func (m *PendingEventManager) Save(event *entities.PendingEvent) error {
	return m.store.Create(event)
}
