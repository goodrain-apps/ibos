FROM goodrainapps/php-apache:5.6.32-jessie

ENV IBOS_VERSION=4.2.2

RUN wget -O /tmp/ibos-$IBOS_VERSION.zip https://gitee.com/ibos/IBOS/repository/archive/${IBOS_VERSION}.zip \
    && unzip /tmp/ibos-$IBOS_VERSION.zip \
    && cd /IBOS \
    && mv * /app \
    && chown rain.rain /app/* -R \
    && rm /tmp/ibos-$IBOS_VERSION.zip

VOLUME /data

EXPOSE 80