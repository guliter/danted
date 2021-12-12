
stty erase '^H' && read -p "请输入宝塔面板添加的MySQL密码：" mysqlpassword
a=&mysqlpassword
b=/etc/init.d/sockd adduser
${b} ${a} ${a}

