package storage

import (
	"context"
	"errors"

	bizmessage "sigma-server/internal/business/message"
	"sigma-server/internal/domain/entities"
	"sigma-server/internal/domain/valueobjects"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

// RecipientReader adapts storage managers to message business ports.
type RecipientReader struct {
	accounts *AccountManager
	chats    *ChatManager
}

func NewRecipientReader(accounts *AccountManager, chats *ChatManager) *RecipientReader {
	return &RecipientReader{accounts: accounts, chats: chats}
}

func (r *RecipientReader) FindRecipient(ctx context.Context, id uuid.UUID) (*bizmessage.RecipientInfo, error) {
	_ = ctx
	account, err := r.accounts.FindByID(id)
	if err != nil {
		return nil, err
	}
	recipientType, ok := valueobjects.ParseRecipientType(account.Type)
	if !ok {
		recipientType = valueobjects.RecipientIndividual
	}
	return &bizmessage.RecipientInfo{ID: account.ID, Type: recipientType}, nil
}

func (r *RecipientReader) ListMembers(ctx context.Context, chatID uuid.UUID) ([]bizmessage.MemberInfo, error) {
	_ = ctx
	rows, err := r.chats.GetMembers(chatID)
	if err != nil {
		return nil, err
	}
	members := make([]bizmessage.MemberInfo, 0, len(rows))
	for _, row := range rows {
		muted, err := r.isMuted(chatID, row.ID)
		if err != nil {
			return nil, err
		}
		memberType, ok := valueobjects.ParseRecipientType(row.Type)
		if !ok {
			memberType = valueobjects.RecipientIndividual
		}
		members = append(members, bizmessage.MemberInfo{
			UserID:  row.ID,
			Type:    memberType,
			IsMuted: muted,
		})
	}
	return members, nil
}

func (r *RecipientReader) isMuted(chatID, userID uuid.UUID) (bool, error) {
	membership, err := r.chats.GetMembership(chatID, userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return false, nil
		}
		return false, err
	}
	return membership.IsMuted, nil
}

func (r *RecipientReader) IsMember(ctx context.Context, chatID, userID uuid.UUID) (bool, error) {
	_ = ctx
	_, err := r.chats.GetMembership(chatID, userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return false, nil
		}
		return false, err
	}
	return true, nil
}

func (r *RecipientReader) GetMembership(ctx context.Context, chatID, userID uuid.UUID) (*entities.Membership, error) {
	_ = ctx
	return r.chats.GetMembership(chatID, userID)
}
