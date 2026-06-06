package main

import (
	"log"

	"sigma-server/internal/app"
	"sigma-server/internal/config"
)

func main() {
	cfg, err := config.LoadConfig("config.yml")
	if err != nil {
		log.Fatal("failed to load configuration:", err)
	}

	if err := app.Run(cfg); err != nil {
		log.Fatal(err)
	}
}
