
read -p "添加Socks5用户（用户和密码相同）0：" tp
stty erase '^H' && read -p "请输入宝塔面板添加的网站目录,宝塔默认地址应该是域名（不带http/https）：" website

/etc/init.d/sockd adduser &tp &tp

echo -e "tp：http://$tp/Admin/login"


echo -e "后台地址：http://$website/Admin/login"
