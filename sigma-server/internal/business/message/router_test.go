package message

import (
	"context"
	"testing"

	"sigma-server/internal/domain/entities"
	"sigma-server/internal/domain/valueobjects"

	"github.com/google/uuid"
)

type stubRecipientStore struct {
	recipient RecipientInfo
	members   []MemberInfo
	member    bool
}

func (s *stubRecipientStore) FindRecipient(ctx context.Context, id uuid.UUID) (*RecipientInfo, error) {
	_ = ctx
	if id != s.recipient.ID {
		return nil, context.Canceled
	}
	return &s.recipient, nil
}

func (s *stubRecipientStore) ListMembers(ctx context.Context, chatID uuid.UUID) ([]MemberInfo, error) {
	_ = ctx
	_ = chatID
	return s.members, nil
}

func (s *stubRecipientStore) IsMember(ctx context.Context, chatID, userID uuid.UUID) (bool, error) {
	_ = ctx
	_ = chatID
	_ = userID
	return s.member, nil
}

func (s *stubRecipientStore) GetMembership(ctx context.Context, chatID, userID uuid.UUID) (*entities.Membership, error) {
	_ = ctx
	_ = chatID
	_ = userID
	return &entities.Membership{}, nil
}

func TestRouterResolveGroupSkipsSenderAndRespectsMute(t *testing.T) {
	sender := uuid.New()
	peer := uuid.New()
	muted := uuid.New()
	chatID := uuid.New()

	store := &stubRecipientStore{
		recipient: RecipientInfo{ID: chatID, Type: valueobjects.RecipientGroup},
		members: []MemberInfo{
			{UserID: sender},
			{UserID: peer},
			{UserID: muted, IsMuted: true},
		},
		member: true,
	}

	plan, err := NewRouter(store).Resolve(context.Background(), sender, chatID)
	if err != nil {
		t.Fatalf("resolve: %v", err)
	}
	if len(plan.Targets) != 2 {
		t.Fatalf("expected 2 targets, got %d", len(plan.Targets))
	}

	mutedFound := false
	for _, target := range plan.Targets {
		if target.UserID == sender {
			t.Fatal("sender should not be a target")
		}
		if target.UserID == muted && target.SkipPush {
			mutedFound = true
		}
	}
	if !mutedFound {
		t.Fatal("muted member should skip push")
	}
}

func TestRouterResolveBot(t *testing.T) {
	sender := uuid.New()
	botID := uuid.New()
	store := &stubRecipientStore{
		recipient: RecipientInfo{ID: botID, Type: valueobjects.RecipientBot},
	}
	plan, err := NewRouter(store).Resolve(context.Background(), sender, botID)
	if err != nil {
		t.Fatalf("resolve: %v", err)
	}
	if !plan.HandleAsBot {
		t.Fatal("expected bot handling")
	}
}
