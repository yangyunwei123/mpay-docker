FROM php:8.2-fpm

# 设置工作目录
WORKDIR /var/www

# 安装系统依赖和 PHP 扩展
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    git \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo_mysql

# 复制 Composer 到镜像中
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 复制入口脚本到镜像中，并赋予执行权限
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# 设置容器启动入口
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
