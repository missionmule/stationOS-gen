#!/bin/bash -e

on_chroot << EOF

rm -rf /etc/dhcpd.conf
rm -rf /etc/dnsmasq.conf
rm -rf /etc/hostapd/hostapd.conf
rm -rf /etc/default/hostapd
rm -rf /etc/sysctl.conf

EOF

install -m 644 files/dhcpd.conf   ${ROOTFS_DIR}/etc/
install -m 644 files/dnsmasq.conf ${ROOTFS_DIR}/etc/
install -m 644 files/hostapd.conf ${ROOTFS_DIR}/etc/hostapd/
install -m 644 files/hostapd      ${ROOTFS_DIR}/etc/default/
install -m 644 files/rc.local     ${ROOTFS_DIR}/etc/

on_chroot << EOF

systemctl enable hostapd
systemctl enable dnsmasq

sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"

EOF
