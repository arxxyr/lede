#!/bin/bash

git pull
./scripts/feeds update -a
./scripts/feeds install -a
git restore .config
make defconfig
make -j$(nproc) download
make -j$(nproc) || make -j1 V=s