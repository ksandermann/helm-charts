#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

WORKDIR=$(pwd)
HELM_BIN="/usr/local/bin/helm3"

declare -a chartlist=(
"teamspeak3"
)

for chart in "${chartlist[@]}";
do
  cd ${WORKDIR}/$chart
  $HELM_BIN lint .
  $HELM_BIN package .
done

cd ${WORKDIR}
$HELM_BIN repo index --url https://github.com/ksandermann/helm-charts/ --merge ./index.yaml .
