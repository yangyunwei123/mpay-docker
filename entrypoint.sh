#!/bin/bash
# 修改挂载进来的目录权限，确保 www-data 用户有读写权限
chown -R www-data:www-data /var/www

# 启动 PHP-FPM
exec php-fpm
