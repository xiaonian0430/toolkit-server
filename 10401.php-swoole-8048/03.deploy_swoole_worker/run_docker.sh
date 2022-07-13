#!/bin/bash

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 初次创建服务
mkdir -p /data/demo_server_php_swoole_worker/www
docker rm -f demo_server_php_swoole_worker
docker run -d -p 59501:9501 --name demo_server_php_swoole_worker -v /data/demo_server_php_swoole_worker/www:/data/www php-swoole-8048:2.0.0 /bin/bash -c "sh run.sh"
