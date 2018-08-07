#!/bin/bash -e

# on_chroot << EOF
#
# rm -rf /lib/systemd/system/systemd-udevd.service
# rm -rf /etc/usbmount/usbmount.conf
#
# EOF
#
#
# install -v -d					 "${ROOTFS_DIR}/lib/systemd/system/"
# install -v -m 644 files/wpa_supplicant.conf	"${ROOTFS_DIR}/etc/wpa_supplicant/"
#
# install -v -d					"${ROOTFS_DIR}/etc/wpa_supplicant"
# install -v -m 644 files/wpa_supplicant.conf	"${ROOTFS_DIR}/etc/wpa_supplicant/"
#
# install -m 644 files/systemd-udevd.service   "${ROOTFS_DIR}/lib/systemd/system/"
# install -m 644 files/usbmount.conf  "${ROOTFS_DIR}/etc/usbmount/"


on_chroot << EOF

chown -R pi:pi /media
chmod -R 777 /media

EOF
