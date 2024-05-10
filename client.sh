#!/bin/bash
yum install -y nfs-utils 
# Включим файрволл
systemctl enable firewalld --now 
firewall-cmd --add-service="nfs3" --add-service="rpc-bind" --add-service="mountd" --permanent 
firewall-cmd --reload
# Настроим шару
echo "192.168.56.200:/srv/share/ /mnt nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0" >> /etc/fstab
systemctl daemon-reload
systemctl restart remote-fs.target
# Создадим тестовый файл
touch /mnt/upload/client_file
# Выводим настройки nfs
nfsstat -m