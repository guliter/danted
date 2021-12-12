
read -p "添加Socks5用户（用户和密码相同）0：" tp
a=&tp
b=/etc/init.d/sockd adduser
${b} ${a} ${a}

