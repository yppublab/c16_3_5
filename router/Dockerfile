FROM alpine:3.20

ENV TZ=Etc/UTC
RUN apk add --no-cache shadow nftables iproute2 iptables sudo bash tcpdump nano vim openrc coredns

COPY /entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 53 53/udp

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
