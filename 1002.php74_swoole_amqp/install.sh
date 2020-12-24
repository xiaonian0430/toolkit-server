# 设置系统时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

yum -y install gcc-c++ make autoconf cmake
yum -y install wget zip unzip git
yum -y install openssl-devel libxml2 libxml2-devel sqlite-devel libcurl-devel

# 安装 nghttp2
# https://github.com/nghttp2/nghttp2/releases/download/v1.41.0/nghttp2-1.41.0.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/f1779d20-ec23-11ea-81ea-f115fe74321c.gz -O nghttp2-1.41.0.tar.gz
tar zxvf nghttp2-1.41.0.tar.gz
cd nghttp2-1.41.0
./configure
make && make install
cd ../
rm -rf nghttp2-1.41.0 nghttp2-1.41.0.tar.gz

# 安装 oniguruma
# https://github.com/kkos/oniguruma/releases/download/v6.9.5/onig-6.9.5.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/f1617d10-ec23-11ea-81ea-f115fe74321c.gz -O onig-6.9.5.tar.gz
tar zxvf onig-6.9.5.tar.gz
cd onig-6.9.5
./configure --libdir=/lib64
make && make install
cd ../
rm -rf onig-6.9.5 onig-6.9.5.tar.gz

# 安装 php7.4
# https://www.php.net/distributions/php-7.4.11.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/php/php-7.4.11.tar.gz -O php-7.4.11.tar.gz
tar zxvf php-7.4.11.tar.gz
cd php-7.4.11
./configure --prefix /usr/local/php74 --with-openssl --with-openssl-dir --enable-sockets --enable-mysqlnd --enable-mbstring --with-curl
make && make install
ln -s -f /usr/local/php74/bin/php /bin/php
ln -s -f /usr/local/php74/bin/php /usr/bin
ln -s -f /usr/local/php74/bin/php /usr/local/bin
ln -s -f /usr/local/php74/bin/phpize /bin/phpize
ln -s -f /usr/local/php74/bin/phpize /usr/bin/phpize
ln -s -f /usr/local/php74/bin/phpize /usr/local/bin/phpize
cd ../
rm -rf php-7.4.11 php-7.4.11.tar.gz

# 安装php swoole 扩展
# https://github.com/swoole/swoole-src/archive/v4.5.5.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/swoole/swoole-src-4.5.5.tar.gz -O swoole-src-4.5.5.tar.gz
tar zxvf swoole-src-4.5.5.tar.gz
cd swoole-src-4.5.5
phpize
./configure --enable-openssl --enable-sockets --enable-http2 --enable-mysqlnd --with-php-config=/usr/local/php74/bin/php-config
make && make install
cd ../
rm -rf swoole-src-4.5.4 swoole-src-4.5.5.tar.gz

# 安装 php amqp 扩展 需要安装rabbitmq-c才能安装扩展。
# https://github.com/alanxz/rabbitmq-c/archive/v0.10.0.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/rabbitmq-c/rabbitmq-c-0.10.0.tar.gz
tar zxvf rabbitmq-c-0.10.0.tar.gz
cd rabbitmq-c-0.10.0
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/rabbitmq-c-0.10.0
make && make install
cp -R /usr/local/rabbitmq-c-0.10.0/lib64/ /usr/local/rabbitmq-c-0.10.0/lib
cd ../
rm -rf rabbitmq-c-0.10.0 rabbitmq-c-0.10.0.tar.gz
# https://pecl.php.net/get/amqp-1.10.2.tgz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/php-amqp/amqp-1.10.2.tgz
tar -xvf amqp-1.10.2.tgz
cd amqp-1.10.2
phpize
./configure --with-php-config=/usr/local/php74/bin/php-config --with-amqp --with-librabbitmq-dir=/usr/local/rabbitmq-c-0.10.0
make && make install
cd ../
rm -rf amqp-1.10.2 amqp-1.10.2.tgz
# 安装 php amqp 扩展 end

# 开启 PHP 扩展
echo "extension=swoole.so" > /usr/local/php74/lib/php.ini
echo "extension=amqp.so" >> /usr/local/php74/lib/php.ini

# composer 包管理工具
# https://www.phpcomposer.com/
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer





