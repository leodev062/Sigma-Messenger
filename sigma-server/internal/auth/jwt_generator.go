package auth

import (
	"fmt"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

type JwtGenerator struct {
	secret string
}

func NewJwtGenerator(jwtSecret string) *JwtGenerator {
	return &JwtGenerator{secret: jwtSecret}
}

func (j *JwtGenerator) secretKey() string {
	if j.secret != "" {
		return j.secret
	}
	return "sigma_chave_super_secreta_em_producao"
}

func (j *JwtGenerator) GenerateToken(userID string, ttl time.Duration) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"userId": userID,
		"exp":    time.Now().Add(ttl).Unix(),
	})

	return token.SignedString([]byte(j.secretKey()))
}

func (j *JwtGenerator) ValidateToken(tokenString string) (string, error) {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
		}
		return []byte(j.secretKey()), nil
	})
	if err != nil {
		return "", err
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok || !token.Valid {
		return "", fmt.Errorf("invalid token claims")
	}

	userID, ok := claims["userId"].(string)
	if !ok || userID == "" {
		return "", fmt.Errorf("missing userId claim")
	}

	return userID, nil
}
