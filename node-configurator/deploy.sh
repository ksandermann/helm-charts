#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

helm upgrade --install \
  node-cfg \
  . \
  --namespace tmp
