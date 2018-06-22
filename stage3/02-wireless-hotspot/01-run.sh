#!/bin/bash -e

on_chroot << EOF

rm -rf /etc/dhcpcd.conf
rm -rf /etc/dnsmasq.conf
rm -rf /etc/hostapd/hostapd.conf
rm -rf /etc/default/hostapd
rm -rf /etc/rc.local
rm -rf /etc/sysctl.conf

EOF

install -m 644 files/dhcpcd.conf  ${ROOTFS_DIR}/etc/dhcpcd.conf
install -m 644 files/dnsmasq.conf ${ROOTFS_DIR}/etc/dnsmasq.conf
install -m 644 files/hostapd.conf ${ROOTFS_DIR}/etc/hostapd/hostapd.conf
install -m 644 files/hostapd      ${ROOTFS_DIR}/etc/default/hostapd
install -m 644 files/rc.local     ${ROOTFS_DIR}/etc/rc.local
install -m 644 files/sysctl.conf  ${ROOTFS_DIR}/etc/sysctl.conf

on_chroot << EOF

iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sh -c "iptables-save > /etc/iptables.ipv4.nat"

systemctl enable hostapd
systemctl enable dnsmasq

EOF
