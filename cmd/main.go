package main

import (
	"log"

	"github.com/gin-gonic/gin"

	"github.com/native-99/community-forum-api/internal/handlers/memberships"
)

func main() {
	r := gin.Default()

	membershipHandler := memberships.NewHandler(r)
	membershipHandler.RegisterRoutes()

	if err := r.Run(":9999"); err != nil {
		log.Fatal(err)
	}
}
