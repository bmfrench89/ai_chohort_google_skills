# --- Build stage -------------------------------------------------------------
# Compile a static binary so the runtime image can stay tiny.
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o server .

# --- Runtime stage -----------------------------------------------------------
FROM alpine:3.20
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 8080
CMD ["./server"]
