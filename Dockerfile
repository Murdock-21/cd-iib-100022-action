FROM d0ck3rmrl22/iib100022

LABEL maintainer "Marcelino Rodriguez <mrodriguezl@tec.com>"

ADD entrypoint.sh /entrypoint.sh

# Copiar en archivos de script
COPY entrypoint.sh /usr/local/bin/
COPY iib-license-check.sh /usr/local/bin/
COPY iib_env.sh /usr/local/bin/
RUN chmod +rx /usr/local/bin/*.sh

# Set BASH_ENV to source mqsiprofile when using docker exec bash -c
ENV BASH_ENV=/usr/local/bin/iib_env.sh
ENV MQSI_MQTT_LOCAL_HOSTNAME=127.0.0.1

# Expose default admin port and http port
EXPOSE 4414 7810

RUN chmod +x /entrypoint.sh

USER iibuser

RUN pwd
# Creacion y permisos para carpeta de archivo bar
RUN mkdir -p /tmp/bar
RUN chmod +rx /tmp/bar
RUN mkdir -p /tmp/deploy
RUN chmod +rx /tmp/deploy

ENTRYPOINT ["/entrypoint.sh"]
