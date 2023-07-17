#We use FORM instruction to specify the base image  
#Build stage 
FROM golang:1.20-alpine3.18 AS builder 

#The WORKDIR instruction to declare
# current working directory inside the image 
WORKDIR /app

#To copy all the necessary files in this folder
#The first dot means to copy everything from the current folder, 
#where we run the docker build command to build image, In this case we build from root of our project. 
#The second dot is current working directory inside the image. 
COPY . .
#-o: stand for output 
RUN go build -o main main.go  
#Run stage 
FROM alpine:3.18 
WORKDIR /app 
COPY --from=builder /app/main . 
COPY .env .
#To spacify that docker lisen to specific port 
EXPOSE 3000
#Defualt command to run when the container start 
CMD ["/app/main"] 