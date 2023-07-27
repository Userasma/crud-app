package models

import "gorm.io/gorm"

type Post struct {
	gorm.Model
	id        int
	FirstName string
	LastName  string
	Email     string
}

// type member struct {
// 	gorm.Model
// 	first_name  string
// 	second_name string
// 	email       string
// }
// type booking struct {
// 	gorm.Model
// 	member_id      int
// 	tickets_number int
// }
