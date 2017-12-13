#!/bin/bash

[ $DEBUG ] && set -x

PermanentDir="/data"
AppDir="/app"
ConfigDir=${AppDir}/system/config/config.php
PermanentConfig=$PermanentDir/system/config/config.php

# 持久化目录处理
if [ ! -d $PermanentDir ];then
    mkdir -p ${PermanentDir}
elif [ ! -d $PermanentDir/data ];then
    mv ${AppDir}/data ${PermanentDir}/ 
elif [ ! -f $PermanentConfig ]
    mv $ConfigDir $PermanentConfig
else 
    mv ${AppDir}/data ${AppDir}/data.bak \
    && mv $ConfigDir $ConfigDir.bak
fi

ln -s ${PermanentDir}/data ${AppDir}/data \
&& ln -s $PermanentDir $ConfigDir
# 修改配置文件
[ -f ${ConfigDir} ] \
    && sed -i -r "s/('username' =>) 'root'/\1 \'$MYSQL_USER\'/" ${ConfigDir} \
    && sed -i -r "s/('password' =>) 'root'/\1 \'$MYSQL_PASS\'/" ${ConfigDir} \

exec httpd -DFOREGROUND