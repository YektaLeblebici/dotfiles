#!/bin/bash

# For each entry in `pipx_list.txt`, run `pipx install`

for package in $(cat pipx_list.txt); do
    echo "Installing $package..."
    pipx install "$package"
done

