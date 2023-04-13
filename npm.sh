#!/bin/sh

PACKAGES=( serverless markdownlint markdownlint-cli yaml-language-server jsonschema2md )

npm install -g "${PACKAGES[@]}"


