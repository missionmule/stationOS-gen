#!/bin/bash -e

on_chroot << EOF

apt-get clean
apt-get autoremove --purge

EOF
