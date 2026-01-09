#!/bin/sh
set -eu

# Network route first (before apk fetches)
ip route del default 2>/dev/null || true
ip route add default via "${GATEWAY_IP}" || true

# User for Nginx
useradd -r -s /sbin/nologin nginx

# Minimal nginx site
rm -f /etc/nginx/http.d/default.conf 2>/dev/null || true

# Разворачиваем sshd + adm пользователя
chmod +x /usr/local/bin/adm.sh
/usr/local/bin/adm.sh
/usr/sbin/sshd

# Start services
nginx -g 'daemon off;' &
# nginx -s reload

sleep infinity
