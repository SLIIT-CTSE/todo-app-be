FROM golang:1.21-alpine AS builder

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .

ENV CGO_ENABLED=0 GOOS=linux
RUN go build -o ./checklist ./src


FROM scratch

COPY --from=builder ["/build/checklist", "/build/.env", "/"]

EXPOSE 8080

CMD ["./checklist"]