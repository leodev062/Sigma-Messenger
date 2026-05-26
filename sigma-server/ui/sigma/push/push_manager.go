package push

import (
	"context"
	"fmt"
	"log"

	firebase "firebase.google.com/go/v4"
	"firebase.google.com/go/v4/auth"
	"firebase.google.com/go/v4/messaging"
	"google.golang.org/api/option"
)

type PushManager struct {
	App                   *firebase.App
	Auth                  *auth.Client
	ServiceAccountKeyPath string
}

func NewPushManager(serviceAccountKeyPath string) *PushManager {
	return &PushManager{ServiceAccountKeyPath: serviceAccountKeyPath}
}

func (p *PushManager) InitFirebase() {
	ctx := context.Background()

	serviceAccountKeyPath := p.ServiceAccountKeyPath
	if serviceAccountKeyPath == "" {
		serviceAccountKeyPath = "serviceAccountKey.json"
	}

	opt := option.WithCredentialsFile(serviceAccountKeyPath)
	app, err := firebase.NewApp(ctx, nil, opt)
	if err != nil {
		log.Printf("⚠️  Erro ao inicializar Firebase App: %v\n", err)
		return
	}

	client, err := app.Auth(ctx)
	if err != nil {
		log.Printf("⚠️  Erro ao inicializar Firebase Auth Client: %v\n", err)
		return
	}

	p.App = app
	p.Auth = client

	fmt.Println("✅ Firebase Admin SDK inicializado com sucesso")
}

func (p *PushManager) SendWakeupPush(fcmToken string) error {
	if p.App == nil {
		return fmt.Errorf("firebase app not initialized")
	}

	ctx := context.Background()
	client, err := p.App.Messaging(ctx)
	if err != nil {
		return err
	}

	message := &messaging.Message{
		Token: fcmToken,
		Data: map[string]string{
			"type": "WAKE_UP",
		},
	}

	_, err = client.Send(ctx, message)
	return err
}
