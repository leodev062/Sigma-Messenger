package storage

import (
	"sigma-server/internal/domain/entities"

	"gorm.io/gorm"
)

type EnvelopeManager struct {
	store *BaseStore[entities.Envelope]
}

func NewEnvelopeManager(db *gorm.DB) *EnvelopeManager {
	return &EnvelopeManager{store: NewBaseStore[entities.Envelope](db)}
}

func (m *EnvelopeManager) Save(envelope *entities.Envelope) error {
	return m.store.Create(envelope)
}

func (m *EnvelopeManager) FindPendingByRecipient(recipientID string) ([]entities.Envelope, error) {
	return m.store.FindWhere("created_at asc", "destination_id = ? AND status = 'pending'", recipientID)
}

func (m *EnvelopeManager) MarkDelivered(envelopeID string) error {
	return m.store.db.Model(&entities.Envelope{}).
		Where("envelope_id = ?", envelopeID).
		Update("status", "delivered").Error
}

func (m *EnvelopeManager) Delete(id int) error {
	return m.store.DeleteByID(id)
}

func (m *EnvelopeManager) DeleteForEnvelopeID(envelopeID string, recipientID string) (int64, error) {
	return m.store.DeleteWhereCount("envelope_id = ? AND destination_id = ?", envelopeID, recipientID)
}
