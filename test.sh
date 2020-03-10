#!/bin/bash
set -o errexit -o pipefail -o nounset

pushd src
  go build -o test-me test.go
  go run run.go "./test-me"
popd

env DOCKER_HOST="" \
    docker build -q --tag linux-test -f linux.Dockerfile . &

env DOCKER_HOST="tcp://192.168.2.129:23750" \
    docker build --isolation=process -q --tag windows-test -f windows.Dockerfile . &

wait

env DOCKER_HOST="" \
    docker run --rm linux-test /run-me /multi-os-script &

env DOCKER_HOST="tcp://192.168.2.129:23750" \
    docker run --isolation=process --rm windows-test run-me.exe multi-os-script &

wait

env DOCKER_HOST="" \
    docker run --rm linux-test /run-me /test-me &

env DOCKER_HOST="tcp://192.168.2.129:23750" \
    docker run --isolation=process --rm windows-test run-me.exe test-me &

wait
