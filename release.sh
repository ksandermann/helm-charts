#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

WORKDIR=$(pwd)
HELM_BIN="/usr/local/bin/helm"

#"checkmk"
#"haproxy-exporter"
declare -a chartlist=(
"teamspeak3"
"checkmk"
"haproxy-exporter"
)

for chart in "${chartlist[@]}";
do
  cd ${WORKDIR}/$chart
  $HELM_BIN lint .
  $HELM_BIN package .
done

cd ${WORKDIR}
$HELM_BIN repo index --url https://ksandermann.github.io/helm-charts/ --merge ./index.yaml .
