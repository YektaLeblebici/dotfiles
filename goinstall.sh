#!/bin/sh

PACKAGES=( github.com/x-motemen/gore/cmd/gore@latest )

go install "${PACKAGES[@]}"

