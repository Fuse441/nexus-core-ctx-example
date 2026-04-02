# STAGE 1: Build the binary
FROM golang:1.24.4-alpine AS builder

# Install git for fetching private dependencies if needed
RUN apk add --no-cache git

# Set working directory
WORKDIR /app

# Copy dependency files first to leverage Docker layer caching
COPY go.mod ./
#RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the application
# CGO_ENABLED=0 creates a statically linked binary (better for minimal images)
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# STAGE 2: Run the binary
FROM alpine:latest

# Set working directory
WORKDIR /root/

# Copy the binary from the builder stage
COPY --from=builder /app/main .

# Expose the application port (e.g., 8080)
EXPOSE 8080

# Run the binary
CMD ["./main"]

