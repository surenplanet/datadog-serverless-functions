#!/bin/sh

# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2019 Datadog, Inc.

# Builds Datadogpy layers for lambda functions, using Docker
set -e

rm -rf bin

# Install datadogpy in a docker container to avoid the mess from switching
# between different python runtimes.
docker build -t datadog-go-layer . --no-cache --build-arg runtime=python:3.7

id=$(docker create datadog-go-layer)
docker cp $id:/go/src/github.com/DataDog/datadog-trace-forwarder/bin .
docker rm -v $id
echo "Done creating archive bin"