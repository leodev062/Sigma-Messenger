package services

import (
	"errors"
	"strings"

	"sigma-server/internal/dto"
	"sigma-server/internal/domain/entities"
	"sigma-server/internal/repository/storage"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type ProfileService struct {
	repo *storage.UserManager
}

func NewProfileService(repo *storage.UserManager) *ProfileService {
	return &ProfileService{repo: repo}
}

func (s *ProfileService) GetByID(requesterID string, userID string) (*entities.User, error) {
	user, err := s.repo.FindByID(userID)
	if err != nil {
		return nil, err
	}
	return user, nil
}

func (s *ProfileService) UpdateProfile(userID string, req dto.UpdateAccountRequest) (*entities.User, error) {
	user, err := s.repo.FindByID(userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("user not found")
		}
		return nil, err
	}

	if req.Username != "" {
		cleanUsername := strings.TrimPrefix(req.Username, "@")
		existing, err := s.repo.FindByUsername(cleanUsername)
		if err == nil && existing.ID != user.ID {
			return nil, errors.New("username already in use")
		}
		user.Username = cleanUsername
	}
	if req.Name != "" {
		user.Name = req.Name
	}
	if req.AvatarURL != "" {
		user.AvatarURL = req.AvatarURL
	}
	if req.Bio != "" {
		user.Bio = req.Bio
	}

	user.UpdatedAt = time.Now().Unix()

	if err := s.repo.Update(user); err != nil {
		return nil, err
	}

	return user, nil
}

func (s *ProfileService) hidePrivateFields(account *entities.Account) *entities.Account {
	masked := *account
	// No Sigma, alguns campos são mantidos como nil em perfis privados para outros usuários.
	// No entanto, para o próprio usuário, todos os campos devem ser retornados.
	// Esta função só deve ser chamada para terceiros.
	masked.Email = nil
	masked.FCMToken = nil
	return &masked
}
