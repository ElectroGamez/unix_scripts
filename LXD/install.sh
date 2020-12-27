#/bin/bash

while ! ping -c 1 -W 1 192.168.1.1 2> /dev/null; do
    echo -ne "Waiting for Network\033[0K\r"
    sleep 2
done

printf "\n\033[0;32mNetwork is up.\033[0;37m" >> /tmp/install.log

printf "\nUpdating system" >> /tmp/install.log
apt update && apt upgrade -y

printf "\nInstalling packages" >> /tmp/install.log
apt install sudo vim openssh-server -y

printf "\nCreating user" >> /tmp/install.log
useradd -s /bin/bash -mU wouter

printf "\nAdding SSH Key" >> /tmp/install.log
mkdir /home/wouter/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG3hJgNwcwfDE0d/patWHjFl9Ex2vGJggUI84vW78Nfp root@GalacticEmpire" > /home/wouter/.ssh/authorized_keys
chown wouter:wouter /home/wouter/.ssh/authorized_keys

echo "wouter ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/wouter

printf "\nInstallation is done!" >> /tmp/install.log

printf "\033[0;32mContainer configured!\n \033[0;36mYou can connect over ssh: \033[0;33m"
printf "$(hostname -I)\033[0;32m\n\n"