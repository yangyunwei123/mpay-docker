#!/bin/bash


echo "请输入MySQL Root密码(密码不会显示)："
read -s MYSQL_ROOT_PASSWORD
echo

read -p "请输入MySQL数据库名（同时作为MySQL用户名）： " MYSQL_DATABASE
# 自动将数据库名作为用户名
MYSQL_USER="${MYSQL_DATABASE}"
echo "MySQL用户名已自动设置为： ${MYSQL_USER}"

echo "请输入MySQL密码(密码不会显示)："
read -s MYSQL_PASSWORD
echo


read -p "请输入未被占用的端口号： " NGINX_PORT
echo "项目端口已设置为： ${NGINX_PORT}"


COMPOSE_FILE="docker-compose.yml"

# 修改 MYSQL_ROOT_PASSWORD
sed -i "s/^\(\s*MYSQL_ROOT_PASSWORD:\s*\).*$/\1${MYSQL_ROOT_PASSWORD}/" ${COMPOSE_FILE}

# 修改 MYSQL_DATABASE
sed -i "s/^\(\s*MYSQL_DATABASE:\s*\).*$/\1${MYSQL_DATABASE}/" ${COMPOSE_FILE}

# 修改 MYSQL_USER
sed -i "s/^\(\s*MYSQL_USER:\s*\).*$/\1${MYSQL_USER}/" ${COMPOSE_FILE}

# 修改 MYSQL_PASSWORD
sed -i "s/^\(\s*MYSQL_PASSWORD:\s*\).*$/\1${MYSQL_PASSWORD}/" ${COMPOSE_FILE}

# 修改端口
sed -i "s/^\(\s*-\s*\"\)[0-9]\+\(:80\".*\)/\1${NGINX_PORT}\2/" ${COMPOSE_FILE}


if [ -f "entrypoint.sh" ]; then
    echo "赋予 entrypoint.sh 可执行权限..."
    chmod +x entrypoint.sh
else
    echo "未找到 entrypoint.sh，请确认文件存在。"
fi


echo "构建并启动 Docker 容器..."
docker compose up -d --build

echo "项目启动完成！"
echo "MySQL数据库已更新: ："
echo "-----------------------------------------"
grep -E "MYSQL_(ROOT_PASSWORD|DATABASE|USER|PASSWORD):" ${COMPOSE_FILE}
echo "-----------------------------------------"
echo "项目端口已设置为: "
grep -E "^\s*-\s*\"[0-9]" ${COMPOSE_FILE}
echo "-----------------------------------------"
MYSQL_CONTAINER_NAME=$(awk '/mysql:/{flag=1} flag && /container_name:/{sub(/^[ \t]*container_name:[ \t]*/, "", $0); print $0; flag=0}' ${COMPOSE_FILE})
echo "MySQL 主机名：${MYSQL_CONTAINER_NAME}"
echo
