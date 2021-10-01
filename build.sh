#!/usr/bin/env bash

set -e

github_remote="https://github.com/"
if [ "$1" == "git" ]; then
  github_remote="git@github.com:"
fi

## prepare mirrorz
if [ ! -e mirrorz/static/json/legacy ]; then
  git clone ${github_remote}mirrorz-org/mirrorz-json-legacy.git mirrorz/static/json/json-legacy
  mv mirrorz/static/json/json-legacy/data mirrorz/static/json/legacy
  rm -rf mirrorz/static/json/json-legacy
fi
if [ ! -e mirrorz/static/json/site ]; then
  git clone ${github_remote}mirrorz-org/mirrorz-json-site.git mirrorz/static/json/site
fi

if [ ! -e mirrorz/src/config ]; then
  git clone ${github_remote}mirrorz-org/mirrorz-config.git mirrorz/src/config
  # prepare mirrorz/src/config/config.json later
fi
if [ ! -e mirrorz/src/parser ]; then
  git clone ${github_remote}mirrorz-org/mirrorz-parser.git mirrorz/src/parser
fi
if [ ! -e mirrorz/src/i18n ]; then
  git clone ${github_remote}mirrorz-org/mirrorz-i18n.git mirrorz/src/i18n
fi

if [ ! -e mirrorz/legacy ]; then
  git clone ${github_remote}mirrorz-org/mirrorz-legacy.git mirrorz/legacy
fi

if [ ! -e mirrorz/scripts/oh-my-mirrorz ]; then
  git clone ${github_remote}mirrorz-org/oh-my-mirrorz.git mirrorz/scripts/oh-my-mirrorz
fi

cp config.json mirrorz/src/config/config.json

## build mirrorz
cd mirrorz
### prepare env
yarn other_ln
yarn legacy_env
### prepare dep
yarn --frozen-lockfile
cd legacy
yarn --frozen-lockfile
cd ..
yarn full_build
cd ../

## copy build output
rm -rf dist
cp -r mirrorz/dist dist
cp dist/_/about/index.html dist/_/index.html # legacy about as legacy front page
rm -r dist/static/json # not used by mirror.z.dn42
