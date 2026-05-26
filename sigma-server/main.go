package main

import (
	"log"

	"sigma-server/ui/sigma"
)

func main() {
	cfg, err := sigma.LoadConfig("config.yml")
	if err != nil {
		log.Fatal("failed to load configuration:", err)
	}

	sigma.SigmaServerService(cfg)
}
