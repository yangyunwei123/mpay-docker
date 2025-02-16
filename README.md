# mpay-docker
码支付 docker compose 部署

1.创建mpay文件夹与docker-compose.yml同级
或者执行

```git clone https://gitee.com/technical-laohu/mpay.git```

2.将项目文件放在mpay中
目录结构应该为:

```text
mpay-docker/
├── docker-compose.yml
├── Dockerfile
├── entrypoint.sh
├── start.sh
├── nginx/
│   └── default.conf
└── mpay/
    ├── public/
    └── ...其他项目文件...
```

3.执行```chmod +x start.sh && ./start.sh```
按照提示输入数据库密码名称端口项目启动之后会输出数据库信息

项目原作者:
https://gitee.com/technical-laohu/mpay


https请使用npm或其他。。。具体教程请Google或者百度
