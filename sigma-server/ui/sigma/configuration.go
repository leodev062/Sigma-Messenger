package sigma

import (
	"sigma-server/ui/sigma/config"
)

type WhisperServerConfiguration = config.WhisperServerConfiguration

func LoadConfig(path string) (*WhisperServerConfiguration, error) {
	return config.LoadConfig(path)
}
