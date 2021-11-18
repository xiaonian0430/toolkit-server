#!/bin/bash
echo $#
echo $2
echo $1

# 启动
if [ "$1"  = "start" ]
then
    # 优化内核
    echo 1 > /proc/sys/vm/overcommit_memory
    echo 50000 > /proc/sys/net/core/somaxconn
    cp -rf ../sentinel.conf ./
    redis-server ./sentinel.conf --daemonize yes --port 6502 --sentinel monitor mymaster 116.85.26.115 6379 2
fi

## 停止服务
if [ "$1"  = "stop" ]
then
    redis-cli -h 127.0.0.1 -p 6502 shutdown
fi

## 查看状态
if [ "$1"  = "status" ]
then
    redis-cli -h 127.0.0.1 -p 6502 info
fi