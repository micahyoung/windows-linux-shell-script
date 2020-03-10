FROM golang:1.13-nanoserver-1809 AS builder

COPY src src

RUN cd src && go build -mod=vendor -o run-me.exe run.go && go build -mod=vendor -o shebang.exe shebang.go && go build -mod=vendor -o test-me.exe test.go

FROM mcr.microsoft.com/windows/nanoserver:1809

COPY --from=builder c:/gopath/src/run-me.exe run-me.exe
COPY --from=builder c:/gopath/src/test-me.exe test-me.exe
COPY --from=builder c:/gopath/src/shebang.exe "#!.exe"

COPY multi-os-script multi-os-script.bat
