FROM alpine:latest

LABEL author "Dmitry Sobolev <ds@napoleonit.ru>"

ENV SUPERVISOR_PID_FILE="/var/run/supervisor.pid"

RUN set -ex; \
    \
    apk add --no-cache --virtual .run-deps \
        supervisor \
        postfix \
        cyrus-sasl \
        bash \
        rsyslog; \
    rm -rf /var/cache/apk/*

COPY bin/postfix.sh /usr/local/bin/
COPY bin/supervisor_killer /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
COPY supervisor.d/* /etc/supervisor.d/

RUN chmod +x /usr/local/bin/postfix.sh; \
    chmod +x /usr/local/bin/supervisor_killer; \
    chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 25

ENTRYPOINT ["entrypoint.sh"]