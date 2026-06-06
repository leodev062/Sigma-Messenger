package config

import appconfig "sigma-server/internal/config"

// HubConfig controls websocket hub runtime behaviour.
type HubConfig struct {
	AllowedOrigins         []string
	MaxConnectionsPerUser  int
	AllowTokenQueryParam   bool
	AllowLegacyUserIDQuery bool
}

func FromServer(cfg appconfig.ServerConfiguration) HubConfig {
	ws := cfg.WebSocket.Normalized()
	return HubConfig{
		AllowedOrigins:         cfg.CORS.ResolvedAllowOrigins(),
		MaxConnectionsPerUser:  ws.MaxConnectionsPerUser,
		AllowTokenQueryParam:   ws.TokenQueryAllowed(),
		AllowLegacyUserIDQuery: ws.AllowLegacyUserIDQuery,
	}
}
