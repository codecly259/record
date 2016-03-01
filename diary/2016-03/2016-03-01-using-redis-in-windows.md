---
layout: post
title: 在windows操作系统中使用redis
description: redis官方支持类unix（linux和mac）系统，在Linux和mac中使用只要按官方文档来即可。但是官方不支持windows操作系统，只是微软开源技术组织()Microsoft Open Tech group)在Github开发了一个win64的redis版本。
category: technology
tags: [windows,redis]
---
{% include JB/setup %}

redis官方不支持windows系统，官网上的描述为：

>The Redis project does not officially support Windows. However, the Microsoft Open Tech group develops and maintains this Windows port targeting Win64

大意为：redis官方是不支持windows的。但是，微软开源技术组织为win64用户开发并维护这个windows版本。要了解更多，请看[项目地址](https://github.com/MSOpenTech/redis)

redis官方支持类unix（linux和mac）系统，在Linux和mac中使用只要按官方文档来即可。
但是官方不支持windows操作系统，只是微软开源技术组织()Microsoft Open Tech group)在Github开发了一个win64的redis版本。

# 快速开始：

```
wget https://github.com/MSOpenTech/redis/releases/download/win-2.8.2400/Redis-x64-2.8.2400.zip #下载，命令不一定可用，只是为了说明要下载文件
rar x-t-o-p Redis-x64-2.8.2400.zip   #解压，命令不一定可用，只是为了说明需要解压
cd Redis-x64-2.8.2400            #到redis目录
redis-server redis.windows.conf  #启动服务，需要先修改配置文件，要不然会出错
redis-cli -h ${ip} -p ${port}    #客户端连接，ip默认为127.0.0.1，port默认为6379
```

- 1,2步命令不一定可以使用，只是为了说明步骤；
- 3,4步必须要以管理员权限运行
- 以上只是为了说明快速开始的步骤，具体细节下面介绍。

## 安装




