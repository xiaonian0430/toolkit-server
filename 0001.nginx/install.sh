# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf

# 第三方的开发包
# 1）pcre
# PCRE(Perl Compatible Regular Expressions)是一个Perl库，包括 perl 兼容的正则表达式库。
# nginx的http模块使用pcre来解析正则表达式，所以需要在linux上安装pcre库。
# 注：pcre-devel是使用pcre开发的一个二次开发库。nginx也需要此库。
yum install -y pcre pcre-devel

# 2）zlib
# zlib库提供了很多种压缩和解压缩的方式，nginx使用zlib对http包的内容进行gzip，所以需要在linux上安装zlib库。
yum install -y zlib zlib-devel

# 3）openssl
# OpenSSL 是一个强大的安全套接字层密码库，囊括主要的密码算法、常用的密钥和证书封装管理功能及SSL协议，并提供丰富的应用程序供测试或其它目的使用。
# nginx不仅支持http协议，还支持https（即在ssl协议上传输http），所以需要在linux安装openssl库。
yum install -y openssl openssl-devel

# wget是Linux中的一个下载文件的工具 
# tar解压工具
yum install -y wget tar

# Stable version
# http://nginx.org/download/nginx-1.18.0.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/nginx/nginx-1.18.0.tar.gz
tar -zxvf nginx-1.18.0.tar.gz
cd nginx-1.18.0
./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-http_gzip_static_module --with-http_v2_module
make && make install
ln -s -f /usr/local/nginx/sbin/nginx /bin/nginx
ln -s -f /usr/local/nginx/sbin/nginx /usr/bin/nginx
ln -s -f /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
cd ../ && rm -rf nginx-1.18.0 nginx-1.18.0.tar.gz

# 配置文件
cd /usr/local/nginx && mkdir -rf conf.d

# 列出所有端口
netstat -ntlp

# 列出80端口
lsof -i tcp:80