#!/bin/sh
echo Building fablol/lede

docker build -t fablol/build-lede-builder -m 2GB -f .\Dockerfile.builder .

docker create --name extract fablol/build-lede-builder
mkdir -p ./bin
docker cp extract:/lede/bin/targets/x86/64/openwrt-x86-64-generic-ext4-combined-efi.img ./bin
docker rm -f extract
