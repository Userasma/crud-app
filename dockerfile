#To reduce the iamge size we need to convert the docker code into tow stage 
#Build stage 
FROM golang:1.20-alpine3.18 AS builder 
WORKDIR /app
#The first dot means copy everything from current folder, where we run docker build command image  
#The secound dot means is the current working directury inside the image, where the files and folder has been copyed.  
COPY . .

#-o stand for output after this the name of the output binary file, then pass this into the entrypoint file"which is main.go".
RUN go build -o main main.go  

# The Run stage 
#FROM alpine:3.18
#WORKDIR /app 
#To copy the executable binary file from the builder stage to run the stage iamge 
#COPY --from=builder /app/main . 
#form argument to tell the file where to copy from  
#To conform that the docker are lisen to spacifiy port at runtime which is 3000 
COPY .env . 
EXPOSE 3000

#The defult command to run when container start, It's an array of command line argument
CMD ["/app/main"] 

#In order to build the image need to type in terminal docker build --help to find the option. 