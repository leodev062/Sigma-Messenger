package services

import (
	"errors"
	"time"

	"sigma-server/internal/dto"
	"sigma-server/internal/domain/entities"
	"sigma-server/internal/repository/storage"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type MessageReactionService struct {
	repo *storage.MessageReactionManager
}

func NewMessageReactionService(repo *storage.MessageReactionManager) *MessageReactionService {
	return &MessageReactionService{repo: repo}
}

func (s *MessageReactionService) AddReaction(userID, messageID uuid.UUID, req dto.MessageReactionRequest) (*entities.MessageReaction, error) {
	if req.Reaction == "" {
		return nil, ErrInvalidReaction
	}

	reaction, err := s.repo.FindByMessageIDAndReactorID(messageID, userID)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, err
	}

	if err == nil {
		reaction.Reaction = req.Reaction
		reaction.CreatedAt = time.Now().UTC()
		if updateErr := s.repo.Update(reaction); updateErr != nil {
			return nil, updateErr
		}
		return reaction, nil
	}

	newReaction := &entities.MessageReaction{
		MessageID: messageID,
		ReactorID: userID,
		Reaction:  req.Reaction,
		CreatedAt: time.Now().UTC(),
	}
	if err := s.repo.Add(newReaction); err != nil {
		return nil, err
	}

	return newReaction, nil
}

func (s *MessageReactionService) RemoveReaction(userID, messageID uuid.UUID) error {
	err := s.repo.Remove(messageID, userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrReactionNotFound
		}
		return err
	}
	return nil
}

func (s *MessageReactionService) GetReactions(messageID uuid.UUID) ([]entities.MessageReaction, error) {
	return s.repo.FindByMessageID(messageID)
}
