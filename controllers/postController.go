package controllers

import (
	"github.com/Asma/go-crud/initializers"
	"github.com/Asma/go-crud/models"
	"github.com/gin-gonic/gin"
)

func PostCreate(c *gin.Context) {
	// Get data off req body

	var body struct {
		Body  string
		Title string
	}
	c.Bind(&body)
	//creat a post
	post := models.Post{Title: body.Title, Body: body.Body}
	result := initializers.DB.Create(&post)

	if result.Error != nil {
		c.Status(400)
		return
	}

	//return it

	c.JSON(200, gin.H{
		"post": post,
	})

}

func PostIndex(c *gin.Context) {
	//get the posts
	var posts []models.Post
	initializers.DB.Find(&posts)

	//respond with them

	c.JSON(200, gin.H{
		"posts": posts,
	})
}

func PostsShow(c *gin.Context) {
	//get id off url
	id := c.Param("id")

	var post []models.Post
	initializers.DB.Find(&post, id)

	//respond with them

	c.JSON(200, gin.H{
		"post": post,
	})

}

func PostsUpdate(c *gin.Context) {
	//Get the Id off URL
	id := c.Param("id")

	//Get the data off request body
	var body struct {
		Body  string
		Title string
	}
	c.Bind(&body)

	//Find the post were updated

	var post []models.Post
	initializers.DB.Find(&post, id)

	//Updated it

	initializers.DB.Model(&post).Updates(models.Post{Title: body.Title, Body: body.Body})

	//Respon with it

	c.JSON(200, gin.H{
		"post": post,
	})
}

func PostDelete(c *gin.Context) {
	//Get the Id off URL
	id := c.Param("id")

	// Delete the post
	initializers.DB.Delete(&models.Post{}, id)

	//Respond

	c.Status(200)
}
