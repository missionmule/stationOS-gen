#!/bin/bash -e

on_chroot << EOF

pip install lxml
pip install paramiko
pip install pymavlink
pip install pyserial
pip install dronekit

EOF
