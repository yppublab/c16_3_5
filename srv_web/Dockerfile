FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC

RUN apt-get update && apt-get install -y --no-install-recommends bash nginx iproute2 sudo nano vim curl wget openssh-server ca-certificates


RUN wget -P /tmp/ https://products.s.kaspersky-labs.com/endpoints/keslinux10/12.3.0.1162/multilanguage-12.3.0.1162/3939393231377c44454c7c31/kesl_12.3.0-1162_amd64.deb

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
