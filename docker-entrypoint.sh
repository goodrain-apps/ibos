#!/bin/bash

[ $DEBUG ] && set -x
Dirs="data system/config"
PermanentDir="/data"
AppDir="/app"
ConfigDir=${AppDir}/system/config/config.php


# 持久化目录处理
[ ! -d $PermanentDir ] && mkdir -p ${PermanentDir}

for d in $Dirs
do 
if [ ! -d $PermanentDir/${d} ];then
   if [ ${d} == "system/config" ];then 
    mkdir -p $PermanentDir/system && mv ${AppDir}/${d} ${PermanentDir}/system
   else
    mv ${AppDir}/${d} ${PermanentDir}
   fi
else 
    mv $AppDir/${d} $AppDir/${d}.bak
fi 

ln -s $PermanentDir/${d} $AppDir/${d}
done

#elif [ ! -d $PermanentDir/data ];then
#    mv ${AppDir}/data ${PermanentDir}/ 
#elif [ ! -f $PermanentConfig ];then
#    mv $ConfigDir $PermanentConfig
#else
#    mv ${AppDir}/data ${AppDir}/data.bak \
#    && mv $ConfigDir ${ConfigDir}.bak
#fi

# 修改配置文件
[ -f ${ConfigDir} ] \
    && sed -i -r "s/('username' =>) '.*'/\1 \'$MYSQL_USER\'/" ${ConfigDir} \
    && sed -i -r "s/('password' =>) '.*'/\1 \'$MYSQL_PASS\'/" ${ConfigDir} \

exec httpd -DFOREGROUND