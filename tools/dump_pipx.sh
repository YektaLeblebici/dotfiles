#!/bin/sh
pipx list --json | jq -r '.venvs | to_entries[] | .key'
