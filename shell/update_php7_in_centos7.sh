# php-7.1.14 NTS  and not DEBUG version
# swoole-4.0.4
# SD-3.6.5


# 先检查 /usr/local/lib 目录下是否有 libiconv

# ubuntu 先检查依赖
# apt-get install libxml2-dev
# apt install libssl-dev # openssl not found
# 如果编译时报iconv找不到，去掉--with-iconv-dir重试

./configure  \
--prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/etc \
--with-config-file-scan-dir=/usr/local/php/conf.d \
--enable-fpm \
--with-fpm-user=www \
--with-fpm-group=www \
--enable-mysqlnd \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-iconv-dir=/usr/local/lib \
--with-freetype-dir=/usr/local/freetype \
--with-jpeg-dir \
--with-png-dir \
--with-zlib \
--with-libxml-dir=/usr \
--enable-xml \
--disable-rpath \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-inline-optimization \
--with-curl \
--enable-mbregex \
--enable-mbstring \
--enable-intl \
--enable-ftp \
--with-gd \
--with-openssl \
--with-mhash \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-zip \
--enable-soap \
--with-gettext \
--enable-opcache \
--with-xsl

make ZEND_EXTRA_LIBS='-liconv'
make install

# 编译安装 swoole
cd swoole-src-4.0.4/
phpize

./configure \
--with-php-config=/usr/local/php/bin/php-config \
--enable-async-redis \
--enable-openssl \
--enable-sockets \
--enable-mysqlnd

make clean
make -j
make install

# 安装 igbinary 扩展
pecl install igbinary

# 安装 redis 扩展
pecl install redis

# 安装 fileinfo 扩展
cd php-7.1.14/ext/fileinfo
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make
make install
# php.ini 中添加行 extension=fileinfo.so

# 安装 inotify 扩展
pecl install inotify
