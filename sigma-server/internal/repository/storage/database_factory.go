package storage

import (
	"fmt"
	"log"

	"sigma-server/internal/config"
	"sigma-server/internal/domain/entities"

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

	// Fix: Forçar alteração de colunas jsonb para bytea para suportar Protobuf (Padrão Signal)
	// Isso resolve o erro "invalid input syntax for type json"
	db.Exec("ALTER TABLE pending_envelopes ALTER COLUMN envelope TYPE bytea USING envelope::bytea")
	db.Exec("ALTER TABLE pending_events ALTER COLUMN payload TYPE bytea USING payload::bytea")

	// TODO: Migrar para golang-migrate/liquibase (semelhante ao Signal)
	if err := db.Exec(`
		DROP TABLE IF EXISTS pre_keys;
		ALTER TABLE recipients
			DROP COLUMN IF EXISTS identity_key,
			DROP COLUMN IF EXISTS signed_pre_key,
			DROP COLUMN IF EXISTS signed_pre_key_id,
			DROP COLUMN IF EXISTS signed_pre_key_public,
			DROP COLUMN IF EXISTS signed_pre_key_signature,
			DROP COLUMN IF EXISTS registration_id,
			DROP COLUMN IF EXISTS pre_keys;
	`).Error; err != nil {
		log.Printf("warning: failed to drop legacy key storage: %v", err)
	}

	if err := db.AutoMigrate(
		&entities.Account{},
		&entities.KeyBundle{},
		&entities.PendingMessage{},
		&entities.PendingEvent{},
		&entities.MessageReaction{},
		&entities.UserDeviceSession{},
		&entities.BotWebhook{},
		&entities.BotUpdate{},
		&entities.BotConversationState{},
	); err != nil {
		log.Printf("warning: failed to run auto migration: %v", err)
	}

	return db, nil
}
