#!/usr/bin/env bash

set -eu
set -o pipefail

readonly ACCESS_LOG=/var/log/nginx/access.log

sudo truncate --size 0 "${ACCESS_LOG}"

cd ~/isucon9-qualify
sudo systemctl stop payment.service shipment.service

./bin/benchmarker -target-url http://127.0.0.1
