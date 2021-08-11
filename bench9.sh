#!/usr/bin/env bash

set -eu
set -o pipefail

readonly ACCESS_LOG=/var/log/nginx/access.log
readonly DB_SLOW_LOG=/var/log/mysql/mysql-slow.log

sudo truncate --size 0 "${ACCESS_LOG}"
sudo truncate --size 0 "${DB_SLOW_LOG}"

sudo systemctl restart isucari.golang.service
sudo systemctl stop payment.service shipment.service

~/isucon9-qualify/bin/benchmarker -target-url http://127.0.0.1
