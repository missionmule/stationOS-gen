#!/bin/bash -e

install -v -d					"${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d"
install -v -m 644 files/wait.conf		"${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/"

install -v -d					"${ROOTFS_DIR}/etc/wpa_supplicant"
install -v -m 600 files/wpa_supplicant.conf	"${ROOTFS_DIR}/etc/wpa_supplicant/"

echo "Configuring wireless access point..."

echo "Installing dhcpcd.conf"
install -m 644 -v files/dhcpcd.conf "${ROOTFS_DIR}/etc/"

echo "Installing dnsmasq.conf"
install -m 644 -v files/dnsmasq.conf  "${ROOTFS_DIR}/etc/"

echo "Installing hostapd.conf"
install -v -d	"${ROOTFS_DIR}/etc/hostapd"
install -m 644 -v files/hostapd.conf  "${ROOTFS_DIR}/etc/hostapd/"

echo "Installing hostapd"
install -m 755 -v files/hostapd "${ROOTFS_DIR}/etc/default/"

echo "Installing sysctl.conf"
install -m 644 -v files/sysctl.conf "${ROOTFS_DIR}/etc/"

echo "Wireless access point configuration complete"
