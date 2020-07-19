#!/bin/bash

creating_ni(){
    echo "Creating tunnel type network interface"
    sudo ip tuntap add mode tun dev tun0
    sudo ip addr add 10.0.0.0/24 dev tun0  
    sudo ip link set dev tun0 up  
    sudo ip route get 10.0.0.2  
}

updating(){
    echo "updating VM"
    sudo yum update -y 
}

new_hostname(){
    NAME="sgilz"
    echo "changing hostname to '$NAME'"
    sudo hostnamectl set-hostname ${NAME}
}

installing_EPEL(){
    echo "installing EPEL from pakage epel-release"
    sudo yum install -y epel-release
}

installing_webserver(){
    echo "installing firewall as a dependency"
    sudo yum install -y firewalld

    echo "starting firewalld"
    sudo systemctl start firewalld
    sudo firewall-cmd --permanent --add-service=ssh
    sudo firewall-cmd --zone=public --permanent --add-port=22/tcp
    echo "installing Apache webserver"
    sudo yum update -y httpd
    sudo yum install -y httpd

    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=https
    sudo firewall-cmd --reload
    sudo systemctl enable firewalld
    
    echo "proving webserver status"
    sudo systemctl start httpd
    sudo systemctl status httpd
    
}

ntp_config(){
    echo "installing ntp package"
    sudo yum install -y ntp
    
    echo "setting timezone"
    sudo timedatectl set-timezone America/Bogota

    echo "enabling ntp"
    sudo systemctl enable ntpd
    sudo systemctl start ntpd
    sudo systemctl stop ntpd
    sudo ntpdate 3.co.pool.ntp.org
    sudo systemctl start ntpd
    ntpstat
}

fail2ban_config(){
    echo "installing fail2band"
    sudo yum update -y epel-release
    sudo yum install -y fail2ban
    sudo systemctl enable --now fail2ban
    sudo systemctl status fail2ban

    echo "configuring fai2ban for ssh"
    sudo bash -c 'echo -e "[sshd]\nenabled = true\nport    = ssh\nfilter   = sshd\nmaxretry = 6" > /etc/fail2ban/jail.d/10-sshd.conf'
    sudo systemctl reload fail2ban
}

installing_nmap(){
    echo "installing nmap"
    sudo yum install -y nmap
}


#using functions for provisioning points

creating_ni
updating
new_hostname
installing_EPEL
installing_webserver
ntp_config
fail2ban_config
installing_nmap

echo "SCRIPT FULLY EXECUTED"

