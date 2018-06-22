#!/bin/bash -e

on_chroot << EOF

apt-get clean
rm -rf /var/lib/apt/lists/*

EOF
