FROM golang:1.21.4-alpine3.19 AS build-stage

WORKDIR /app

COPY . .

RUN go mod download

RUN go build -o /goapp

FROM alpine:3.19 AS build-release-stage

WORKDIR /

COPY --from=build-stage /goapp /goapp

EXPOSE 8080

ENTRYPOINT ["./goapp"]