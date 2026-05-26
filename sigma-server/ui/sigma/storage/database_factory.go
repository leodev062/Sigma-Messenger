package storage

import (
	"fmt"
	"log"

	"sigma-server/ui/sigma/config"
	"sigma-server/ui/sigma/entities"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func NewDatabaseFactory(cfg config.PostgresConfiguration) (*gorm.DB, error) {
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=%s TimeZone=%s",
		cfg.Host,
		cfg.User,
		cfg.Password,
		cfg.DBName,
		cfg.Port,
		cfg.SSLMode,
		cfg.Timezone,
	)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		return nil, err
	}

	// TODO: Migrar para golang-migrate/liquibase (semelhante ao Signal)
	if err := db.AutoMigrate(&entities.Account{}, &entities.PreKey{}, &entities.PendingMessage{}, &entities.PendingEvent{}); err != nil {
		log.Printf("warning: failed to run auto migration: %v", err)
	}

	return db, nil
}
