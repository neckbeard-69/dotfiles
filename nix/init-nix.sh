#!/bin/sh

# link nixos config
sudo rm /etc/nixos/configuration.nix
ln -s ./configuration.nix /etc/nixos

sudo nixos-rebuild switch
