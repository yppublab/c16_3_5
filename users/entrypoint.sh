#!/usr/bin/env bash

# Adjust default route via firewall
ip route del default || true
ip route add default via "$GATEWAY_IP" || true

set -euo pipefail

# Разворачиваем sshd + adm пользователя
chmod +x /usr/local/bin/adm.sh
/usr/local/bin/adm.sh
/usr/sbin/sshd

useradd -m -s /bin/bash -p "${USER_HASH}" ${USERNAME} || true


#разворачиваем kesl
cat >/tmp/kesl.ini <<EOF
EULA_AGREED=yes
PRIVACY_POLICY_AGREED=yes
SERVICE_LOCALE=en_US.UTF-8
USE_KSN=yes
USE_GUI=no
INSTALL_LICENSE=
GROUP_CLEAN=no
ScanMemoryLimit=2048
USE_SYSTEMD=yes
EOF

apt-get install /tmp/kesl_12.3.0-1162_amd64.deb
/opt/kaspersky/kesl/bin/kesl-setup.pl --autoinstall=/tmp/kesl.ini


sleep infinity
