package app

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"sigma-server/internal/config"
)

// Run builds the application, starts HTTP/WebSocket workers, and shuts down gracefully.
func Run(cfg *config.WhisperServerConfiguration) error {
	application, err := NewApplication(cfg)
	if err != nil {
		return err
	}
	defer func() {
		if err := application.Close(); err != nil {
			log.Printf("Application close error: %v", err)
		}
	}()

	go application.WS.Hub.Run()

	port := cfg.Server.Port
	if port == "" {
		port = "3000"
	}

	errCh := make(chan error, 1)
	go func() {
		if err := application.Echo.Start(":" + port); err != nil && err != http.ErrServerClosed {
			errCh <- err
		}
	}()

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt, syscall.SIGTERM)

	select {
	case err := <-errCh:
		return fmt.Errorf("http server: %w", err)
	case <-quit:
	}

	shutdownCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	if err := application.Echo.Shutdown(shutdownCtx); err != nil {
		return fmt.Errorf("http shutdown: %w", err)
	}

	application.WS.Hub.Shutdown(shutdownCtx)
	return nil
}
