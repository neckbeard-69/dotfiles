#!/bin/sh

# link nixos config
sudo rm /etc/nixos/configuration.nix
sudo ln -s /home/mohammed/dotfiles/nix/configuration.nix /etc/nixos/configuration.nix

sudo nixos-rebuild switch
