#!/bin/bash

# Ставим инструменты
yum install -y nfs-utils
# Настроим файрволл
systemctl enable firewalld --now
firewall-cmd --add-service="nfs3" --add-service="rpc-bind" --add-service="mountd" --permanent 
firewall-cmd --reload
# Включаем сервер nfs
systemctl enable nfs-server --now
# Настраиваем шару
mkdir -p /srv/share/upload 
chown -R nobody:nobody /srv/share
chmod 0777 /srv/share/upload
cat << EOF > /etc/exports 
/srv/share 192.168.56.0/24(rw,sync,root_squash)
EOF
# Экспортируем шару
exportfs -vr
# Создаём пробный файл
touch /srv/share/upload/check_file