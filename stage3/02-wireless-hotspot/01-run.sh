#!/bin/bash -e

echo "Removing old IP configuration files..."

on_chroot << EOF

rm -f "${ROOTFS_DIR}/etc/dhcpcd.conf"
rm -f  "${ROOTFS_DIR}/etc/dnsmasq.conf"
rm -f  "${ROOTFS_DIR}/etc/default/hostapd"
rm -f  "${ROOTFS_DIR}/etc/rc.local"
rm -f  "${ROOTFS_DIR}/etc/sysctl.conf"

EOF

echo "IP configuration files removal complete"

echo "Configuring wireless access point..."

echo "Installing dhcpcd.conf"
install -m 644 -v files/dhcpcd.conf "${ROOTFS_DIR}/etc/dhcpcd.conf"

echo "Installing dnsmasq.conf"
install -m 644 -v files/dnsmasq.conf  "${ROOTFS_DIR}/etc/dnsmasq.conf"

echo "Installing hostapd.conf"
install -m 644 -v files/hostapd.conf  "${ROOTFS_DIR}/etc/hostapd/hostapd.conf"

echo "Installing hostapd"
install -m 755 -v files/hostapd "${ROOTFS_DIR}/etc/default/hostapd"

echo "Installing rc.local"
install -m 755 -v files/rc.local  "${ROOTFS_DIR}/etc/rc.local"

echo "Installing sysctl.conf"
install -m 644 -v files/sysctl.conf "${ROOTFS_DIR}/etc/sysctl.conf"

echo "Wiress access point configuration complete"

on_chroot << EOF

iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sh -c "iptables-save > /etc/iptables.ipv4.nat"

EOF

on_chroot << EOF

systemctl enable hostapd
systemctl enable dnsmasq

EOF
