#!/bin/bash -e

# on_chroot << EOF
#
# systemctl disable hostapd
# systemctl disable dnsmasq
#
# EOF

# echo "Removing old IP configuration files..."

# rm -f "${ROOTFS_DIR}/etc/dhcpcd.conf"
# rm -f "${ROOTFS_DIR}/etc/dnsmasq.conf"
# rm -f "${ROOTFS_DIR}/etc/default/hostapd"
# rm -f "${ROOTFS_DIR}/etc/sysctl.conf"

# echo "IP configuration files removal complete"
#
# echo "Configuring wireless access point..."
#
# echo "Installing dhcpcd.conf"
# install -m 644 -v files/dhcpcd.conf "${ROOTFS_DIR}/etc/"
#
# echo "Installing dnsmasq.conf"
# install -m 644 -v files/dnsmasq.conf  "${ROOTFS_DIR}/etc/"
#
# echo "Installing hostapd.conf"
# install -m 644 -v files/hostapd.conf  "${ROOTFS_DIR}/etc/hostapd/"
#
# echo "Installing hostapd"
# install -m 755 -v files/hostapd "${ROOTFS_DIR}/etc/default/"
#
# echo "Installing sysctl.conf"
# install -m 644 -v files/sysctl.conf "${ROOTFS_DIR}/etc/"
#
# echo "Wireless access point configuration complete"

cat > /etc/dnsmasq.conf <<EOF
interface=wlan0
dhcp-range=10.0.0.2,10.0.0.5,255.255.255.0,12h
EOF

cat > /etc/hostapd/hostapd.conf <<EOF
interface=wlan0
hw_mode=g
channel=10
auth_algs=1
wpa=2
wpa_key_mgmt=WPA-PSK
wpa_pairwise=CCMP
rsn_pairwise=CCMP
wpa_passphrase=12345678
ssid=MissionMule
ieee80211n=1
wmm_enabled=1
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
EOF

cat > /etc/sysctl.conf <<EOF
net.ipv4.ip_forward=1
EOF

sed -i -- 's/allow-hotplug wlan0//g' /etc/network/interfaces
sed -i -- 's/iface wlan0 inet manual//g' /etc/network/interfaces
sed -i -- 's/    wpa-conf \/etc\/wpa_supplicant\/wpa_supplicant.conf//g' /etc/network/interfaces
sed -i -- 's/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/g' /etc/default/hostapd

cat >> /etc/network/interfaces <<EOF
# Added by rPi Access Point Setup
allow-hotplug wlan0
iface wlan0 inet static
	address 10.0.0.1
	netmask 255.255.255.0
	network 10.0.0.0
	broadcast 10.0.0.255
EOF

echo "denyinterfaces wlan0" >> /etc/dhcpcd.conf

on_chroot << EOF

iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sh -c "iptables-save > /etc/iptables.ipv4.nat"

EOF

on_chroot << EOF

systemctl enable hostapd
systemctl enable dnsmasq

EOF
