#!/bin/bash -e

on_chroot << EOF

rm -rf /opt/mission-mule
mkdir -p /opt/mission-mule

cd /opt/mission-mule && git clone -v https://github.com/missionmule/data-station.git

EOF

install -m 644 files/data-station-power-management.service   "${ROOTFS_DIR}/lib/systemd/system/"

on_chroot << EOF

systemctl enable data-station-power-management
systemctl disable hciuart

EOF
