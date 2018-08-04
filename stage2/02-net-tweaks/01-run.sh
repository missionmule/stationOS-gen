#!/bin/bash -e

install -v -d					"${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d"
install -v -m 644 files/wait.conf		"${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/"

install -v -d					"${ROOTFS_DIR}/etc/wpa_supplicant"
install -v -m 600 files/wpa_supplicant.conf	"${ROOTFS_DIR}/etc/wpa_supplicant/"

echo "Installing Jessie backwards compatible systemd-udevd service config"
install -v -d					"${ROOTFS_DIR}/lib/systemd/system/"
install -m 644 files/systemd-udevd.service   "${ROOTFS_DIR}/lib/systemd/system/"

echo "Installing usbmount custom config"
install -v -d					"${ROOTFS_DIR}/lib/systemd/usbmount/"
install -m 644 files/usbmount.conf  "${ROOTFS_DIR}/etc/usbmount/"

echo "Installing 72-wlan-geo-dependent.rules"
install -m 644 -v files/72-wlan-geo-dependent.rules "${ROOTFS_DIR}/etc/udev/rules.d/"
