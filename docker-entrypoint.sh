#!/bin/bash

[ $DEBUG ] && set -x

PermanentDir="/data"
AppDir="/app"

# 持久化目录处理
[ -d ${AppDir}/data ] \
&& mkdir -pv ${PermanentDir} \
&& mv ${AppDir}/data ${PermanentDir}/ \
&& ln -s ${PermanentDir}/data ${AppDir}/data
# 修改配置文件
[ -f ${AppDir}/config.php ] \
&& sed -i -r "s/username/$MYSQL_USER/" ${AppDir}/config.php \
&& sed -i -r "s/password/$MYSQL_PASS/" ${AppDir}/config.php \
&& sed -i -r "s/host/$MYSQL_HOST/" ${AppDir}/config.php \
&& sed -i -r "s/port/$MYSQL_PORT/" ${AppDir}/config.php