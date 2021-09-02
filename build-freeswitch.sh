#!/bin/bash
PLATFORM=$1

if [[ -z $1 ]]; then
    PLATFORM=linux/arm/v7,linux/amd64
fi

pushd freeswitch
docker buildx build --platform ${PLATFORM} --push -t crazyquark/freeswitch .
popd