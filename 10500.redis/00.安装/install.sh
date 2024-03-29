ulimit -HSn 102400
echo 1 > /proc/sys/vm/overcommit_memory
echo 50000 > /proc/sys/net/core/somaxconn
echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
echo 0 > /proc/sys/net/ipv4/tcp_syncookies
# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y yum-utils
yum install -y gcc gcc-c++ make automake autoconf
yum install -y lsof net-tools sysstat tree iotop
yum install -y wget tar curl git unzip zip zlib zlib-devel openssl openssl-devel

# redis
# https://github.com/redis/redis/archive/refs/tags/7.0.11.tar.gz
wget https://gitee.com/xiaonian0430/sources/raw/master/redis-7.last.tar.gz -O redis-release.tar.gz --no-check-certificate
rm -rf redis-release /usr/local/redis-release
mkdir -p redis-release
tar -zxvf redis-release.tar.gz -C ./redis-release --strip-components 1
cd redis-release
make && make install PREFIX=/usr/local/redis-release
cd ../ && rm -rf redis-release redis-release.tar.gz
ln -s -f /usr/local/redis-release/bin/redis-server /usr/bin/redis-server
ln -s -f /usr/local/redis-release/bin/redis-cli /usr/bin/redis-cli
ln -s -f /usr/local/redis-release/bin/redis-sentinel /usr/bin/redis-sentinel