#!/bin/bash

PACKAGES=( serverless markdownlint markdownlint-cli yaml-language-server @adobe/jsonschema2md )

npm install -g "${PACKAGES[@]}"


