FROM goodrainapps/php-apache:5.6.32-jessie

ENV IBOS_VERSION=4.2.2

RUN wget -O /tmp/ibos-$IBOS_VERSION.zip https://gitee.com/ibos/IBOS/repository/archive/${IBOS_VERSION}.zip \
    && cd /tmp/IBOS \
    && mv * /app \
    && chown rain.rain * -R \
    && rm /tmp/ibos-$IBOS_VERSION.zip

VOLUME /data

EXPOSE 80