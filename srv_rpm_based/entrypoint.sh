#!/bin/sh
set -eu

ip route del default 2>/dev/null || true
ip route add default via "$GATEWAY_IP" || true

#######################################################
# Создание скрипта установки KESL с проверкой маркера
cat > /usr/local/bin/install_kesl.sh << 'EOF'
#!/bin/sh
set -eu

echo "Installing KESL..."

# Конфигурация KESL
cat > /tmp/kesl.ini << INI_EOF
EULA_AGREED=yes
PRIVACY_POLICY_AGREED=yes
SERVICE_LOCALE=en_US.UTF-8
USE_KSN=yes
USE_GUI=no
INSTALL_LICENSE=
GROUP_CLEAN=no
ScanMemoryLimit=2048
USE_SYSTEMD=yes
INI_EOF

# Установка пакета и настройка
rpm -i /tmp/kesl-12.3.0-1162.x86_64.rpm
/opt/kaspersky/kesl/bin/kesl-setup.pl --autoinstall=/tmp/kesl.ini

# Создание маркера установки
touch "$MARKER_FILE"
echo "KESL installation completed."
EOF
#######################################################

# Делаем скрипт исполняемым
chmod +x /usr/local/bin/install_kesl.sh


# Добавление задания в cron для запуска при старте
CRON_JOB="* * * * * root /usr/local/bin/install_kesl.sh >> /var/log/cron-kesl.log 2>&1"
CRON_FILE="/etc/cron.d/kesl-cron"

echo "$CRON_JOB" > "$CRON_FILE"
chmod 0644 "$CRON_FILE" 


chmod +x /usr/local/bin/adm.sh
/usr/local/bin/adm.sh
/usr/sbin/sshd


exec /usr/sbin/init
