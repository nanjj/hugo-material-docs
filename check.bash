#!/usr/bin/env bash
go_install="apt install golang"
which brew &> /dev/null && os_install="brew install go"
go version &>/dev/null || "echo ${go_install}"
test -n "${GOPATH}" &>/dev/null || echo "export GOPATH=~/go"
hugo version &>/dev/null || echo "go get github.com/spf13/hugo"
pygmentize -V &>/dev/null || echo "pip install pygments"
