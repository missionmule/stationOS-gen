#!/bin/bash -e

on_chroot << EOF

rm -rf /opt/mission-mule
mkdir -p /opt/mission-mule

cd /opt/mission-mule && git clone -v https://github.com/missionmule/firefly-mule.git

cd /opt/mission-mule/firefly-mule && pip3 install -r /opt/mission-mule/firefly-mule/requirements.txt

EOF

install -m 644 files/mission-mule-avionics.service   "${ROOTFS_DIR}/lib/systemd/system/"

on_chroot << EOF

systemctl enable mission-mule-avionics
systemctl disable hciuart

EOF
