#!/bin/sh

PACKAGES=( serverless markdownlint markdownlint-cli yaml-language-server @adobe/jsonschema2md @google/gemini-cli @anthropic-ai/claude-code @openai/codex )

npm install -g "${PACKAGES[@]}"


