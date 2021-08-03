#!/usr/bin/env bash
# Usage: ./serve.sh[port]

set -x

cd dist/ && python3 ../mirrorz/scripts/gh-cors.py $1
