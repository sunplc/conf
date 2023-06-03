# First, cd to /path/to/php-src/

brew install bison

# 由于macOS 已安装了 bison旧版本 2.x，所以brew 把新版本bison 3.x 安装在homebrew的目录里，
# 所以需要修改PATH环境变量，临时让 configure 程序可以找到新版本bison
export PATH="/opt/homebrew/opt/bison/bin:$PATH"

brew install pkg-config

brew install re2c

brew install libiconv

export LDFLAGS="-L/opt/homebrew/opt/libiconv/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libiconv/include"


brew install openssl

export OPENSSL_LIBS="-L/opt/homebrew/opt/openssl@3.1/lib"
export OPENSSL_CFLAGS="-I/opt/homebrew/opt/openssl@3.1/include"

export PKG_CONFIG_PATH=/opt/homebrew/opt/openssl@3.1/lib/pkgconfig

autoconf

autoheader

./configure  \
--prefix=/Users/sc/php \
--with-config-file-path=/Users/sc/php/etc \
--with-config-file-scan-dir=/Users/sc/php/conf.d \
--enable-fpm \
--with-fpm-user=www \
--with-fpm-group=www \
--enable-mysqlnd \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-iconv=/opt/homebrew/opt/libiconv \
--with-zlib \
--enable-xml \
--disable-rpath \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-inline-optimization \
--with-curl \
--enable-mbregex \
--enable-mbstring \
--enable-ftp \
--with-openssl \
--with-mhash \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-opcache 

make -j8

# 最终make失败，怀疑是 openssl 库文件缺失
