#!/bin/bash

# 创建docker网络
create_network_event(){
    filter_name=`docker network ls | grep docker_network | awk '{ print $2 }'`
    if [ "$filter_name" == "" ]; then
        #不存在就创建
        docker network create --subnet 172.19.0.0/24 --gateway 172.19.0.1 docker_network
        echo 'docker_network created [\e[32mok\e[0m]'
    else
        echo -e 'docker_network [\e[32mok\e[0m]'
    fi
}
create_network_event


mkdir -p /data/redis_server_001/conf/
mkdir -p /data/redis_server_001/runtime/
mkdir -p /data/redis_server_001/data/
cp -rf ./redis.conf /data/redis_server_001/conf/redis.conf
docker-compose up -d




