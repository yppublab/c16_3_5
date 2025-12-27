FROM rockylinux:9

ENV container docker


# Установка пакетов
RUN dnf -y update && \
    dnf -y install \
        sudo \
        vim \
        systemd \
        systemd-libs \
        systemd-pam \
        firewalld \
        iproute \
        procps-ng \
        wget \
        passwd \
        dbus \
        policycoreutils \
        openssh-server \
        policycoreutils-python-utils \
        selinux-policy-targeted \
        && \
    dnf clean all
RUN wget -P /tmp/ https://products.s.kaspersky-labs.com/endpoints/keslinux10/12.3.0.1162/multilanguage-12.3.0.1162/3939393231387c44454c7c31/kesl-12.3.0-1162.x86_64.rpm


# Создаем группу admins (для su)
RUN groupadd admins

# Разрешаем systemd внутри контейнера
VOLUME ["/sys/fs/cgroup"]

STOPSIGNAL SIGRTMIN+3

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod u+rw /etc/shadow
CMD ["/usr/local/bin/entrypoint.sh"]