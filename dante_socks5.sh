


# 设置字体颜色函数
function blue(){
    echo -e "\033[34m\033[01m $1 \033[0m"
}
function green(){
    echo -e "\033[32m\033[01m $1 \033[0m"
}
function greenbg(){
    echo -e "\033[43;42m\033[01m $1 \033[0m"
}
function red(){
    echo -e "\033[31m\033[01m $1 \033[0m"
}
function redbg(){
    echo -e "\033[37;41m\033[01m $1 \033[0m"
}
function yellow(){
    echo -e "\033[33m\033[01m $1 \033[0m"
}
function white(){
    echo -e "\033[37m\033[01m $1 \033[0m"
}

#工具安装
install_pack() {
    pack_name="基础工具"
    echo "===> Start to install curl"    
    if [ -x "$(command -v yum)" ]; then
        command -v curl > /dev/null || yum install -y curl
    elif [ -x "$(command -v apt)" ]; then
        command -v curl > /dev/null || apt install -y curl
    else
        echo "Package manager is not support this OS. Only support to use yum/apt."
        exit -1
    fi    
}




Dante_socks5(){
    #check root
    wget --no-check-certificate https://raw.githubusercontent.com/guliter/danted/dev/install.sh -O install.sh&&bash install.sh  --port="9527" --user="789" --passwd="789"
echo   
red "默认添加用户密码为：789 789 端口：9527"
echo
}

uninstall_socks5(){
    bash install.sh --uninstall
}

socks5_add(){
/etc/init.d/sockd adduser GameOn GameOn
echo    
red "默认添加用户密码为：GameOn GameOn"
echo
blue  "命令提示：/etc/init.d/sockd adduser 用户名 密码"
echo
}



socks5_status(){
    #check root
    /etc/init.d/sockd  status

}

socks5_restart(){
    #check root
    /etc/init.d/sockd  restart

}

socks5_deluser(){
/etc/init.d/sockd  status
echo 
red "命令提示：/etc/init.d/sockd deluser 用户名"
echo 
yellow "备选方案：/etc/danted/sockd.passwd 手动删除指定用户！"

echo 

}

dante() {
	if [[ ! -d "/etc/danted" ]]; then
		red " ---> 没有检测到安装目录，请执行脚本安装内容"
	fi
	 red "---Socks5 Dante 多IP服务已经安装！"
	

}
#开始菜单
start_menu(){
    clear
    echo
    white "—————————————【Socks5多IP服务器搭建】——————————————"
    red "1.Socks5---【多IP进出口 Dante】"
    blue "2.Socks5---【服务重启 Dante】"
    green "3.Socks5---【查看状态 Dante】"
    yellow "4.Socks5---【添加用户 Dante】"
    red "5.Socks5---【删除用户 Dante】"
    blue "6.Socks5---【卸载 Dante】"
    blue "Dante服务安装情况："
    dante
    red "—————————————【如需退出按【0】退出选项】——————————————"
    echo
    echo
    read -p "请输入数字:" num
    case "$num" in
    1)
    Dante_socks5
    ;;
    2)
    socks5_restart
    ;;
    3)
    socks5_status
    ;;
    4)
    socks5_add
    ;;
    5)
    socks5_deluser
    ;;
    6)
    uninstall_socks5
    ;;
    0)
    exit 1
    ;;
    *)
    clear
    echo "请输入正确数字"
    sleep 3s
    start_menu
    ;;
    esac
}
start_menu


