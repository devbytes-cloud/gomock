FROM golang:1.17-alpine AS build_deps

RUN apk add --no-cache git

WORKDIR /workspace

COPY go.mod .

FROM build_deps AS build

COPY . .
ARG VERSION

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags "-s -w" -o gomock .

FROM alpine:3.13.5

RUN apk add --no-cache ca-certificates

COPY --from=build /workspace/gomock /usr/local/bin/gomock

ENTRYPOINT ["gomock"]