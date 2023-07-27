# Build stage
FROM golang:1.20-alpine3.18 AS builder

ENV GOPATH /go
# Install git (required by go get)
#RUN apk add --no-cache git

WORKDIR /app
COPY . .

# Build your Go application
RUN go build -o main main.go

# Download Golang Migrate
# To download and set up migrate binary manually
RUN apk add --no-cache wget
RUN wget -O migrate.linux-amd64.tar.gz https://github.com/golang-migrate/migrate/releases/download/v4.14.1/migrate.linux-amd64.tar.gz
RUN tar -xzf migrate.linux-amd64.tar.gz
#RUN mkdir -p /usr/local/bin
RUN mv migrate.linux-amd64 /usr/local/bin/migrate
RUN rm migrate.linux-amd64.tar.gz

# Set executable permissions for the migrate binary
RUN chmod +x /usr/local/bin/migrate

# Run stage
FROM alpine:3.18
WORKDIR /app
# Copy the Golang Migrate binary from the builder stage
COPY --from=builder app/main .
COPY --from=builder migrate ./migrate
#PS: when I start to create a tablet I need to write it here. 
COPY .env .
COPY start.sh .
COPY wait-for.sh .
COPY db/migration ./migration
EXPOSE 3000
CMD ["/app/main"]
ENTRYPOINT ["/app/start.sh"]
