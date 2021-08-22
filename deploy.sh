#!/usr/bin/env bash

set -eu
set -o pipefail
set -x

cd ~/webapp
git pull

if [[ $# -ge 1 ]];then
  git checkout $1
else
  git checkout master
fi

cd go
go build -mod=mod .

sudo systemctl restart isucondition.go.service

cd ~/
