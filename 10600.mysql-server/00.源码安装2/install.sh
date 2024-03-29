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
yum install -y gcc gcc-c++ make automake autoconf lsof net-tools tree
yum install -y wget tar curl git unzip zip zlib zlib-devel 
yum install -y centos-release-scl
yum install -y devtoolset-11-gcc devtoolset-11-gcc-c++ devtoolset-11-binutils
# 第三方的开发包
yum install -y bison bzip2 hostname ncurses-devel pkgconfig doxygen

# cmake3
yum remove cmake
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/cmake-3.23.1-linux-x86_64.sh -O cmake3-release.sh --no-check-certificate
sh cmake3-release.sh --prefix=/usr/local --exclude-subdir
ln -s -f /usr/local/bin/cmake /usr/bin/cmake

# openssl
# https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_1_1_1o.tar.gz
function install_openssl(){
    wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/openssl-OpenSSL_1_1_1o.tar.gz -O openssl-release.tar.gz
    rm -rf openssl-release /usr/local/openssl-release
    mkdir -p openssl-release
    tar -zxvf openssl-release.tar.gz -C ./openssl-release --strip-components 1
    cd openssl-release
    ./config --prefix=/usr/local/openssl-release
    ./config -t
    make
    make install
    cd ../
    rm -rf openssl-release openssl-release.tar.gz
    ln -s -f /usr/local/openssl-release/bin/openssl /usr/bin/openssl
    #ln -s -f /usr/local/openssl-release/include/openssl /usr/include/openssl
    echo "/usr/local/openssl-release/lib">> /etc/ld.so.conf
    ldconfig
    openssl version
}
if ! type openssl >/dev/null 2>&1; then
    echo 'openssl 未安装'
    install_openssl
else
    echo 'openssl 已安装'
fi

# mysql
# https://github.com/mysql/mysql-server/archive/refs/tags/mysql-8.0.29.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/mysql-server-mysql-8.0.29.tar.gz -O mysql-release.tar.gz --no-check-certificate
rm -rf mysql-release && /usr/local/mysql-release
mkdir -p mysql-release
tar -zxvf mysql-release.tar.gz -C ./mysql-release --strip-components 1
cd mysql-release
rm -rf builder
mkdir builder
cd builder
cmake ../ \
-DWITH_SSL=system \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql-release \
-DMYSQL_DATADIR=/usr/local/mysql-data \
-DSYSCONFDIR=/etc \
-DMYSQL_USER=mysql \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_FEDERATED_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 \
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
-DMYSQL_TCP_PORT=3306 \
-DENABLED_LOCAL_INFILE=1 \
-DENABLE_DOWNLOADS=1 \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_general_ci \
-DWITH_DEBUG=0 \
-DMYSQL_MAINTAINER_MODE=0 \
-DDOWNLOAD_BOOST=1 \
-DWITH_BOOST=../boost

make && make install
cd ../../ && rm -rf mysql-release mysql-release.tar.gz
ln -s -f /usr/local/mysql-release/bin/mysql /usr/bin/mysql