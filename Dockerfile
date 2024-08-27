FROM golang:1.23-alpine AS builder

WORKDIR /build
COPY . /build

RUN go mod download
RUN go build -o /go-whois-server ./cmd/server/


# Create a new release build stage
FROM alpine:latest

# Set the working directory to the root directory path
WORKDIR /

# Copy over the binary built from the previous stage
COPY --from=builder /go-whois-server /go-whois-server

EXPOSE 8080
CMD ["/go-whois-server"]
