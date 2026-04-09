# STAGE 1: Build the binary
FROM golang:1.24.4-alpine AS builder

RUN apk add --no-cache git

WORKDIR /app

COPY go.mod ./
# RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main .


# STAGE 2: Run the binary
FROM alpine:latest

# 👉 เพิ่ม curl ตรงนี้
RUN apk add --no-cache curl

WORKDIR /root/

COPY --from=builder /app/main .

# ⚠️ แนะนำให้ตรงกับ app (คุณใช้ 3000)
EXPOSE 3000

CMD ["./main"]
