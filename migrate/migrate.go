package main

import (
	"github.com/Asma/go-crud/initializers"
	"github.com/Asma/go-crud/models"
)

func init() {
	initializers.LoadEnvVariables()
	initializers.ConnectToDB()

}

func main() {
	initializers.DB.AutoMigrate(&models.Post{})

}
