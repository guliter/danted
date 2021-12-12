export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
stty erase '^H' && read -p "密码：" mysqlpassword
a=&'mysqlpassword'
b='/etc/init.d/sockd adduser'

${b} ${a} ${a}


