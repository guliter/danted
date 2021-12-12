
stty erase '^H' && read -p "密码：" mysqlpassword
a=&mysqlpassword
/etc/init.d/sockd adduser ${a} ${a}


