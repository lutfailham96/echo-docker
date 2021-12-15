##
## Build
##

FROM golang:1.16-alpine AS builder

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY *.go ./

RUN go build -o myapp

##
## Deploy
##

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/myapp myapp

EXPOSE 8080

#USER nonroot:nonroot
USER nobody:nobody

ENTRYPOINT ["/app/myapp"]
