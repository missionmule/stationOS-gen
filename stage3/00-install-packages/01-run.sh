#!/bin/bash -e

on_chroot << EOF

pip3 install lxml
pip3 install paramiko
pip3 install pymavlink
pip3 install pyserial
pip3 install dronekit

EOF
