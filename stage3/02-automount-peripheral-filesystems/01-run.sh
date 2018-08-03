#!/bin/bash -e

on_chroot << EOF

rm -rf /lib/systemd/system/systemd-udevd.service
rm -rf /etc/usbmount/usbmount.conf

EOF

install -m 644 files/systemd-udevd.service   "${ROOTFS_DIR}/lib/systemd/system/"
install -m 644 files/usbmount.conf  "${ROOTFS_DIR}/etc/usbmount/"
