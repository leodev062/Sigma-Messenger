package config

import (
	"fmt"
	"os"
	"strings"

	"gopkg.in/yaml.v3"
)

type WhisperServerConfiguration struct {
	Server    ServerConfiguration         `yaml:"server"`
	Database  PostgresConfiguration       `yaml:"database"`
	Auth      AuthConfiguration           `yaml:"auth"`
	Push      PushServiceConfiguration    `yaml:"push"`
	Telephony TelephonyConfiguration      `yaml:"telephony"`
	Payment   PaymentConfiguration        `yaml:"payment"`
	Account   AccountServiceConfiguration `yaml:"account"`
	Redis     RedisConfiguration          `yaml:"redis"`
}

type PostgresConfiguration struct {
	Host     string `yaml:"host"`
	Port     string `yaml:"port"`
	User     string `yaml:"user"`
	Password string `yaml:"password"`
	DBName   string `yaml:"dbname"`
	SSLMode  string `yaml:"sslmode,omitempty"`
	Timezone string `yaml:"timezone,omitempty"`
}

type AuthConfiguration struct {
	JWTSecret string `yaml:"jwt_secret"`
}

type PushServiceConfiguration struct {
	FirebaseServiceAccountPath string `yaml:"firebase_service_account_path"`
}

type AccountServiceConfiguration struct {
	DefaultType string `yaml:"default_type,omitempty"`
}

type TelephonyConfiguration struct {
	Provider string `yaml:"provider"`
	APIKey   string `yaml:"api_key"`
}

type PaymentConfiguration struct {
	MercadoPagoAccessToken string `yaml:"mercadopago_access_token"`
}

type ServerConfiguration struct {
	Port string `yaml:"port"`
}

type RedisConfiguration struct {
	Mode       string   `yaml:"mode,omitempty"`
	Address    string   `yaml:"address,omitempty"`
	Addresses  []string `yaml:"addresses,omitempty"`
	Password   string   `yaml:"password,omitempty"`
	DB         int      `yaml:"db,omitempty"`
	MasterName string   `yaml:"master_name,omitempty"`
}

func (cfg RedisConfiguration) Normalized() RedisConfiguration {
	normalized := cfg
	normalized.Addresses = normalizeRedisAddresses(cfg.Addresses)
	if len(normalized.Addresses) == 0 && strings.TrimSpace(cfg.Address) != "" {
		normalized.Addresses = []string{strings.TrimSpace(cfg.Address)}
	}
	if normalized.Mode == "" {
		if len(normalized.Addresses) > 1 {
			normalized.Mode = "cluster"
		} else {
			normalized.Mode = "single"
		}
	}
	return normalized
}

func normalizeRedisAddresses(values []string) []string {
	addresses := make([]string, 0, len(values))
	for _, value := range values {
		trimmed := strings.TrimSpace(value)
		if trimmed != "" {
			addresses = append(addresses, trimmed)
		}
	}
	return addresses
}

func LoadConfig(path string) (*WhisperServerConfiguration, error) {
	data, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}

	var cfg WhisperServerConfiguration
	if err := yaml.Unmarshal(data, &cfg); err != nil {
		return nil, err
	}

	cfg.Redis = cfg.Redis.Normalized()

	if cfg.Database.SSLMode == "" {
		cfg.Database.SSLMode = "disable"
	}

	if cfg.Database.Timezone == "" {
		cfg.Database.Timezone = "UTC"
	}

	if cfg.Server.Port == "" {
		cfg.Server.Port = "3000"
	}

	if err := cfg.Validate(); err != nil {
		return nil, err
	}

	return &cfg, nil
}

func (cfg *WhisperServerConfiguration) Validate() error {
	missing := make([]string, 0)

	if strings.TrimSpace(cfg.Auth.JWTSecret) == "" {
		missing = append(missing, "auth.jwt_secret")
	}

	if strings.TrimSpace(cfg.Database.Host) == "" {
		missing = append(missing, "database.host")
	}
	if strings.TrimSpace(cfg.Database.Port) == "" {
		missing = append(missing, "database.port")
	}
	if strings.TrimSpace(cfg.Database.User) == "" {
		missing = append(missing, "database.user")
	}
	if strings.TrimSpace(cfg.Database.Password) == "" {
		missing = append(missing, "database.password")
	}
	if strings.TrimSpace(cfg.Database.DBName) == "" {
		missing = append(missing, "database.dbname")
	}
	if len(cfg.Redis.Addresses) == 0 {
		missing = append(missing, "redis.address or redis.addresses")
	}
	if cfg.Redis.Mode == "single" && len(cfg.Redis.Addresses) > 1 {
		missing = append(missing, "redis.mode=single cannot be used with multiple redis.addresses")
	}
	if cfg.Redis.Mode == "sentinel" && strings.TrimSpace(cfg.Redis.MasterName) == "" {
		missing = append(missing, "redis.master_name")
	}

	if cfg.Telephony.Provider != "mock" && cfg.Telephony.Provider != "" {
		if strings.TrimSpace(cfg.Telephony.APIKey) == "" {
			missing = append(missing, "telephony.api_key")
		}
	}

	if len(missing) > 0 {
		return fmt.Errorf("missing or invalid configuration fields: %s", strings.Join(missing, ", "))
	}

	return nil
}
