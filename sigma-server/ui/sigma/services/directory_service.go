package services

import (
	"sigma-server/ui/sigma/entities"
	"sigma-server/ui/sigma/storage"
)

type DirectoryService struct {
	repo *storage.AccountManager
}

func NewDirectoryService(repo *storage.AccountManager) *DirectoryService {
	return &DirectoryService{repo: repo}
}

func (s *DirectoryService) CheckUsername(username string) bool {
	_, err := s.repo.FindByUsername(username)
	return err != nil
}

func (s *DirectoryService) SyncContacts(phones []string) ([]entities.Account, error) {
	return s.repo.FindByPhones(phones)
}

func (s *DirectoryService) SearchAccounts(term string, limit int) ([]entities.Account, error) {
	return s.repo.Search(term, limit)
}
