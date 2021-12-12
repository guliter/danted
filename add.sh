#/bin/sh

apt update -yqq
apt install -yqq ppp build-essential cmake gcc linux-headers-`uname -r` git libpcre3-dev libssl-dev liblua5.1-0-dev


# Accel-ppp Installation
ping -c1 google.com 1>/dev/null 2>/dev/null
if [ $? -eq 0 ]; then
git clone https://github.com/accel-ppp/accel-ppp.git accel-ppp-code
else
git clone https://hub.fastgit.org/xebd/accel-ppp.git accel-ppp-code
fi

mkdir /opt/accel-ppp-code/build
cd /opt/accel-ppp-code/build/
cmake -DCMAKE_INSTALL_PREFIX=/usr -DKDIR=/usr/src/linux-headers-`uname -r` -DCPACK_TYPE=Ubuntu`lsb_release -rs | cut -d'.' -f1` ..
make
cpack -G DEB
dpkg -i accel-ppp.deb



mv /etc/accel-ppp.conf.dist /etc/accel-ppp.conf

cat <<EOF > /etc/accel-ppp.conf
[modules]
log_file
log_syslog
log_tcp
l2tp
pptp
auth_mschap_v2
auth_mschap_v1
auth_chap_md5
auth_pap
chap-secrets
ippool

[core]
log-error=/var/log/accel-ppp/core.log
thread-count=4

[ppp]
verbose=1
mtu=1500
mru=1500
ipv4=require
ipv6=deny

[pptp]
verbose=1

[l2tp]
verbose=1

[dns]
dns1=114.114.114.114
dns2=119.29.29.29

[client-ip-range]
0.0.0.0/0

[ip-pool]
gw-ip-address=10.0.0.1
attr=Framed-Pool
10.0.0.0/24

[log]
log-file=/var/log/accel-ppp/accel-ppp.log
log-emerg=/var/log/accel-ppp/emerg.log
log-fail-file=/var/log/accel-ppp/auth-fail.log
copy=1
level=3

[pppd-compat]
verbose=1
ip-up=/etc/ppp/ip-up
ip-down=/etc/ppp/ip-down


[chap-secrets]
gw-ip-address=10.0.0.1
chap-secrets=/etc/ppp/chap-secrets
EOF

cat <<EOF > /etc/ppp/chap-secrets
admin1 * admin1 *

EOF

sed -ri 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sysctl -p
systemctl enable accel-ppp
systemctl start accel-ppp
systemctl status accel-ppp
