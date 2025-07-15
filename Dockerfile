FROM golang:1.23.5-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
#Эта команда позволяет кешировать зависимости, и благодаря этому запускается быстрее
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

FROM alpine:3.22.0
WORKDIR /app
COPY --from=builder /app /app
CMD ["./main"]
