#!/bin/sh
echo Building fablol/lede

docker build -t fablol/build-lede-builder -m 2GB -f .\Dockerfile.builder .

docker create --name extract fablol/build-lede-builder
mkdir ./bin
docker cp extract:/lede/bin/targets/x86/64/* ./bin
docker rm -f extract
