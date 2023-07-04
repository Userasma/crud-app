package main

import (
	"github.com/Asma/go-crud/controllers"
	"github.com/Asma/go-crud/initializers"
	"github.com/gin-gonic/gin"
)

func init() {
	initializers.LoadEnvVariables()
	initializers.ConnectToDB()
 
}

func main() {
	r := gin.Default()
	r.POST("/posts", controllers.PostCreate)
	r.PUT("/posts/:id", controllers.PostsUpdate)
	r.GET("/posts", controllers.PostIndex)
	//this work as a dynamic router
	r.GET("/posts/:id", controllers.PostsShow)
	r.DELETE("/posts/:id", controllers.PostDelete)

	r.Run()
}
