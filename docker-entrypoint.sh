#!/bin/bash

[ $DEBUG ] && set -x

PermanentDir="/data"
AppDir="/app"
ConfigDir=${AppDir}/system/config/config.php

# 持久化目录处理
if [ ! -d $PermanentDir ];then
    mkdir -p ${PermanentDir}
elif [ ! -d $PermanentDir/data ];then
    mv ${AppDir}/data ${PermanentDir}/ 
else 
    mv ${AppDir}/data ${AppDir}/data.bak
fi

ln -s ${PermanentDir}/data ${AppDir}/data

# 修改配置文件
[ -f ${ConfigDir} ] \
    && sed -i -r "s/('username' =>) 'root'/\1 \'$MYSQL_USER\'/" ${ConfigDir} \
    && sed -i -r "s/('password' =>) 'root'/\1 \'$MYSQL_PASS\'/" ${ConfigDir} \
    && sed -i -r "s/('tableprefix' =>) '.*'/\1 \'ibos_\'/" ${ConfigDir} \

exec httpd -DFOREGROUND