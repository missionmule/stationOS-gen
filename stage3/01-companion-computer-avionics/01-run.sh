#!/bin/bash -e

on_chroot << EOF

rm -rf /opt/mission-mule
mkdir -p /opt/mission-mule

cd /opt/mission-mule && git clone -v https://github.com/missionmule/data-mule.git

EOF

install -m 644 files/mission-mule-avionics.service   ${ROOTFS_DIR}/lib/systemd/system/mission-mule-avionics.service

on_chroot << EOF

systemctl enable mission-mule-avionics.service

EOF
