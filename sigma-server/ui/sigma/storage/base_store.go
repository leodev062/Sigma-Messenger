package storage

import (
	"gorm.io/gorm"
)

type BaseStore[T any] struct {
	db *gorm.DB
}

func NewBaseStore[T any](db *gorm.DB) *BaseStore[T] {
	return &BaseStore[T]{db: db}
}

func (s *BaseStore[T]) Create(record *T) error {
	return s.db.Create(record).Error
}

func (s *BaseStore[T]) DeleteByID(id any) error {
	return s.db.Delete(new(T), id).Error
}

func (s *BaseStore[T]) DeleteWhere(query string, args ...any) error {
	return s.db.Where(query, args...).Delete(new(T)).Error
}

func (s *BaseStore[T]) FindWhere(order string, query string, args ...any) ([]T, error) {
	var records []T
	err := s.db.Where(query, args...).Order(order).Find(&records).Error
	return records, err
}
