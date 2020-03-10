FROM golang:1.13-alpine AS builder

COPY src src

RUN cd src && go build -mod=vendor -o run-me run.go && go build -mod=vendor -o test-me test.go

FROM alpine

COPY --from=builder /go/src/run-me /run-me
COPY --from=builder /go/src/test-me /test-me

COPY multi-os-script multi-os-script
