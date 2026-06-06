package storage

import (
	"gorm.io/gorm"

	"sigma-server/internal/domain/entities"

	"github.com/google/uuid"
)

type MessageReactionManager struct {
	db    *gorm.DB
	store *BaseStore[entities.MessageReaction]
}

func NewMessageReactionManager(db *gorm.DB) *MessageReactionManager {
	return &MessageReactionManager{db: db, store: NewBaseStore[entities.MessageReaction](db)}
}

func (m *MessageReactionManager) Add(reaction *entities.MessageReaction) error {
	return m.store.Create(reaction)
}

func (m *MessageReactionManager) Update(reaction *entities.MessageReaction) error {
	return m.db.Save(reaction).Error
}

func (m *MessageReactionManager) Remove(messageID, reactorID uuid.UUID) error {
	result := m.db.Where("message_id = ? AND reactor_id = ?", messageID, reactorID).Delete(&entities.MessageReaction{})
	if result.Error != nil {
		return result.Error
	}
	if result.RowsAffected == 0 {
		return gorm.ErrRecordNotFound
	}
	return nil
}

func (m *MessageReactionManager) FindByMessageID(messageID uuid.UUID) ([]entities.MessageReaction, error) {
	return m.store.FindWhere("created_at asc", "message_id = ?", messageID)
}

func (m *MessageReactionManager) FindByMessageIDAndReactorID(messageID, reactorID uuid.UUID) (*entities.MessageReaction, error) {
	var reaction entities.MessageReaction
	err := m.db.Where("message_id = ? AND reactor_id = ?", messageID, reactorID).First(&reaction).Error
	return &reaction, err
}
