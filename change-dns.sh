#!/bin/bash

set -e

echo "Creating systemd-resolved config for DNS-over-TLS..."
sudo mkdir -p /etc/systemd/resolved.conf.d

sudo tee /etc/systemd/resolved.conf.d/dns.conf >/dev/null <<EOF
[Resolve]
DNS=1.1.1.1 1.0.0.1
FallbackDNS=8.8.8.8 8.8.4.4
DNSOverTLS=yes
EOF

echo "Linking /etc/resolv.conf to systemd stub resolver..."
sudo rm -f /etc/resolv.conf
sudo ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

echo "Restarting systemd-resolved service..."
sudo systemctl restart systemd-resolved
sudo systemctl enable systemd-resolved

echo "Checking DNS status..."
systemd-resolve --status | grep 'DNS Servers'

echo "Dns changed"
