#!/bin/bash

lsps=(
	gopls typescript-language-server golangci-lint
	lua-language-server
) 

for lsp in "${lsps[@]}"; do
    sudo pacman -S "$lsp" --noconfirm
done

go install github.com/nametake/golangci-lint-langserver@latest
