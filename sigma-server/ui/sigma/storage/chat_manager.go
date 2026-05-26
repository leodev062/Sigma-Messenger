package storage

import (
	"errors"

	"sigma-server/ui/sigma/entities"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type ChatSummaryRow struct {
	ID          uuid.UUID `gorm:"column:id"`
	Type        string    `gorm:"column:type"`
	Title       string    `gorm:"column:title"`
	Description string    `gorm:"column:description"`
	Role        string    `gorm:"column:role"`
	IsMuted     bool      `gorm:"column:is_muted"`
	MemberCount int       `gorm:"column:member_count"`
}

type ChatMemberRow struct {
	ID       uuid.UUID `gorm:"column:id"`
	Name     string    `gorm:"column:name"`
	Username string    `gorm:"column:username"`
	Phone    string    `gorm:"column:phone"`
	Avatar   string    `gorm:"column:avatar_url"`
	Bio      string    `gorm:"column:bio"`
	Role     string    `gorm:"column:role"`
}

type AddMembersResult struct {
	Added          []uuid.UUID
	AlreadyPresent []uuid.UUID
	CurrentCount   int
	MaxMembers     int
}

type MemberLimitExceededError struct {
	ChatType     string
	CurrentCount int
	MaxMembers   int
}

func (e *MemberLimitExceededError) Error() string {
	return FormatMemberLimitReachedMessage(e.ChatType, e.MaxMembers)
}

type ChatManager struct {
	db *gorm.DB
}

func NewChatManager(db *gorm.DB) *ChatManager {
	return &ChatManager{db: db}
}

func (m *ChatManager) Create(room *entities.Account, ownerID uuid.UUID) error {
	return m.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(room).Error; err != nil {
			return err
		}
		membership := &entities.Membership{
			ChatID: room.ID,
			UserID: ownerID,
			Role:   "owner",
		}
		if err := tx.Create(membership).Error; err != nil {
			return err
		}
		return tx.Model(room).Update("participant_count", 1).Error
	})
}

func (m *ChatManager) HasOwnedChatType(ownerID uuid.UUID, chatType string) (bool, error) {
	var count int64
	err := m.db.Model(&entities.Account{}).Where("owner_id = ? AND type = ?", ownerID, chatType).Count(&count).Error
	return count > 0, err
}

func (m *ChatManager) GetUserChats(userID uuid.UUID) ([]ChatSummaryRow, error) {
	var results []ChatSummaryRow
	query := `
		SELECT r.id, r.type, r.display_name as title, r.bio as description, m.role, m.is_muted,
			COALESCE(r.participant_count, 0) as member_count
		FROM recipients r
		JOIN memberships m ON r.id = m.recipient_id
		WHERE m.user_id = ?`

	err := m.db.Raw(query, userID).Scan(&results).Error
	return results, err
}

func (m *ChatManager) AddMembers(chatID uuid.UUID, userIDs []uuid.UUID) (*AddMembersResult, error) {
	var result AddMembersResult

	err := m.db.Transaction(func(tx *gorm.DB) error {
		var chat entities.Account
		if err := tx.First(&chat, chatID).Error; err != nil {
			return err
		}

		seen := map[uuid.UUID]struct{}{}
		uniqueUserIDs := make([]uuid.UUID, 0, len(userIDs))
		for _, userID := range userIDs {
			if userID == uuid.Nil {
				continue
			}
			if _, ok := seen[userID]; ok {
				continue
			}
			seen[userID] = struct{}{}
			uniqueUserIDs = append(uniqueUserIDs, userID)
		}

		var owner entities.Account
		if chat.OwnerID != nil {
			if err := tx.First(&owner, *chat.OwnerID).Error; err != nil {
				if !errors.Is(err, gorm.ErrRecordNotFound) {
					return err
				}
			}
		}

		currentCount := int64(0)
		if err := tx.Model(&entities.Membership{}).Where("recipient_id = ?", chatID).Count(&currentCount).Error; err != nil {
			return err
		}

		newUserIDs := make([]uuid.UUID, 0, len(uniqueUserIDs))
		for _, userID := range uniqueUserIDs {
			var existing entities.Membership
			err := tx.Where("recipient_id = ? AND user_id = ?", chatID, userID).First(&existing).Error
			if err == nil {
				result.AlreadyPresent = append(result.AlreadyPresent, userID)
				continue
			}
			if !errors.Is(err, gorm.ErrRecordNotFound) {
				return err
			}
			newUserIDs = append(newUserIDs, userID)
		}

		if chat.Type == ChatTypeGroup || chat.Type == ChatTypeChannel {
			limit := EffectiveMemberLimit(chat.Type, owner.VerificationType)
			if limit > 0 && int(currentCount)+len(newUserIDs) > limit {
				result.CurrentCount = int(currentCount)
				result.MaxMembers = limit
				return &MemberLimitExceededError{ChatType: chat.Type, CurrentCount: int(currentCount), MaxMembers: limit}
			}
		}

		for _, userID := range newUserIDs {
			membership := entities.Membership{
				ChatID: chatID,
				UserID: userID,
				Role:   RoleMember,
			}
			if err := tx.Create(&membership).Error; err != nil {
				return err
			}
			result.Added = append(result.Added, userID)
		}

		updatedCount := int64(0)
		if err := tx.Model(&entities.Membership{}).Where("recipient_id = ?", chatID).Count(&updatedCount).Error; err != nil {
			return err
		}
		result.CurrentCount = int(updatedCount)
		result.MaxMembers = EffectiveMemberLimit(chat.Type, owner.VerificationType)

		return tx.Model(&entities.Account{}).Where("id = ?", chatID).Update("participant_count", updatedCount).Error
	})

	return &result, err
}

func (m *ChatManager) GetMembers(chatID uuid.UUID) ([]ChatMemberRow, error) {
	var results []ChatMemberRow
	query := `
		SELECT r.id, r.display_name as name, r.username, r.phone, r.avatar_url, r.bio, m.role
		FROM memberships m
		JOIN recipients r ON m.user_id = r.id
		WHERE m.recipient_id = ?`

	err := m.db.Raw(query, chatID).Scan(&results).Error
	return results, err
}

func (m *ChatManager) GetMembership(chatID, userID uuid.UUID) (*entities.Membership, error) {
	var membership entities.Membership
	err := m.db.Where("recipient_id = ? AND user_id = ?", chatID, userID).First(&membership).Error
	return &membership, err
}

func (m *ChatManager) ResolveMembers(chatID uuid.UUID) ([]uuid.UUID, error) {
	var members []uuid.UUID
	err := m.db.Raw(`SELECT user_id FROM memberships WHERE recipient_id = ?`, chatID).Scan(&members).Error
	return members, err
}

func (m *ChatManager) UpdateChat(chatID uuid.UUID, updates map[string]interface{}) error {
	return m.db.Model(&entities.Account{}).Where("id = ?", chatID).Updates(updates).Error
}

func (m *ChatManager) DeleteChat(chatID uuid.UUID) error {
	return m.db.Delete(&entities.Account{}, chatID).Error
}

func (m *ChatManager) RemoveMember(chatID, userID uuid.UUID) error {
	return m.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Where("recipient_id = ? AND user_id = ?", chatID, userID).Delete(&entities.Membership{}).Error; err != nil {
			return err
		}
		return tx.Model(&entities.Account{}).Where("id = ?", chatID).Update("participant_count", gorm.Expr("(SELECT COUNT(*) FROM memberships WHERE recipient_id = ?)", chatID)).Error
	})
}

func (m *ChatManager) FindByID(id uuid.UUID) (*entities.Account, error) {
	var room entities.Account
	err := m.db.First(&room, id).Error
	return &room, err
}

func (m *ChatManager) Update(room *entities.Account) error {
	return m.db.Save(room).Error
}

func (m *ChatManager) ResolveContacts(userID uuid.UUID) ([]uuid.UUID, error) {
	var contacts []uuid.UUID
	err := m.db.Raw(`
		SELECT DISTINCT m2.user_id
		FROM memberships m1
		JOIN memberships m2 ON m2.recipient_id = m1.recipient_id
		WHERE m1.user_id = ?
			AND m2.user_id <> ?
	`, userID, userID).Scan(&contacts).Error
	return contacts, err
}
