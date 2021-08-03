#!/usr/bin/env bash

set -e

## copy config
cp mirrors.js mirrorz/src/config/mirrors.js
cp upstream.ts mirrorz/src/config/upstream.ts

## build mirrorz
cd mirrorz
yarn --frozen-lockfile
yarn build
yarn legacy_build
## cleanup
git reset --hard
cd ../

## cp build output

cp -r mirrorz/dist ./
