FROM golang:1.21-alpine AS build-env

# Install necessary dependencies
RUN apk add --no-cache make git libc-dev bash gcc linux-headers eudev-dev

# Set working directory
WORKDIR /go/src/github.com/leonaries/my-blockchain

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the binary
RUN make build

# Final image
FROM alpine:latest

# Install ca-certificates
RUN apk add --no-cache ca-certificates curl

# Create a user to run the application
RUN addgroup -g 1000 blockchain && adduser -u 1000 -G blockchain -D -h /home/blockchain blockchain

# Set working directory
WORKDIR /home/blockchain

# Copy binary from build stage
COPY --from=build-env /go/src/github.com/leonaries/my-blockchain/build/my-blockchaind /usr/bin/my-blockchaind

# Change ownership
RUN chown blockchain:blockchain /usr/bin/my-blockchaind

# Switch to non-root user
USER blockchain

# Expose ports
EXPOSE 26656 26657 1317 9090

# Default command
CMD ["my-blockchaind", "start"]
