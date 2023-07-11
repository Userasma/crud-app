#Build stage 
FROM golang:1.20-alpine3.18 
WORKDIR /app
COPY . .
RUN go build -o main main.go  

COPY .env .

EXPOSE 3000
CMD ["/app/main"] 