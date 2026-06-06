package storage

import "testing"

func TestCanManageChatRoles(t *testing.T) {
	tests := []struct {
		name string
		role string
		want bool
	}{
		{name: "owner can manage", role: RoleOwner, want: true},
		{name: "admin can manage", role: RoleAdmin, want: true},
		{name: "member cannot manage", role: RoleMember, want: false},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := CanManageChat(tt.role); got != tt.want {
				t.Fatalf("CanManageChat(%q) = %v, want %v", tt.role, got, tt.want)
			}
		})
	}
}

func TestCanDeleteChatRoles(t *testing.T) {
	if !CanDeleteChat(RoleOwner) {
		t.Fatal("CanDeleteChat(owner) = false, want true")
	}
	if CanDeleteChat(RoleAdmin) {
		t.Fatal("CanDeleteChat(admin) = true, want false")
	}
}

func TestFormatMemberLimitReachedMessage(t *testing.T) {
	got := FormatMemberLimitReachedMessage(ChatTypeGroup, 1000)
	want := "o grupo já atingiu o limite máximo de 1000 membros"
	if got != want {
		t.Fatalf("FormatMemberLimitReachedMessage() = %q, want %q", got, want)
	}
}
