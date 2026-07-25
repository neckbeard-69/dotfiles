{ pkgs }:

with pkgs;
[
  # nix lsp
  nil
  # Go
  go
  gopls
  air
  sqlc
  golangci-lint
  golangci-lint-langserver

  # JavaScript / TypeScript
  nodejs
  pnpm
  typescript-language-server
  tailwindcss-language-server

  # Other languages
  rustc
  cargo
  gcc
  lua-language-server

  # Containers
  docker
  lazydocker

  # API development
  bruno
  openssl

  # Terminal
  ghostty

  # Databse
  postgresql
  lazysql
  beekeeper-studio
]
