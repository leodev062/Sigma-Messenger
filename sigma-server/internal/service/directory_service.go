package services

import (
	"sigma-server/internal/domain/entities"
	"sigma-server/internal/repository/storage"
)

type DirectoryService struct {
	repo *storage.UserManager
}

func NewDirectoryService(repo *storage.UserManager) *DirectoryService {
	return &DirectoryService{repo: repo}
}

func (s *DirectoryService) CheckUsername(username string) bool {
	_, err := s.repo.FindByUsername(username)
	return err != nil
}

func (s *DirectoryService) SyncContacts(phones []string) ([]entities.User, error) {
	return s.repo.FindByPhones(phones)
}

func (s *DirectoryService) SearchAccounts(term string, limit int) ([]entities.User, error) {
	return s.repo.Search(term, limit)
}
