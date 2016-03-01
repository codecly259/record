---
layout: post
title: 在windows操作系统中使用redis
description: redis官方支持类unix（linux和mac）系统，在Linux和mac中使用只要按官方文档来即可。但是官方不支持windows操作系统，只是微软开源技术组织()Microsoft Open Tech group)在Github开发了一个win64的redis版本。
category: technology
tags: [windows,redis]
---
{% include JB/setup %}

* TOC
{:toc}

redis官方不支持windows系统，官网上的描述为：

>The Redis project does not officially support Windows. However, the Microsoft Open Tech group develops and maintains this Windows port targeting Win64

大意为：redis官方是不支持windows的。但是，微软开源技术组织为win64用户开发并维护这个windows版本。要了解更多，请看[项目地址](https://github.com/MSOpenTech/redis)

redis官方支持类unix（linux和mac）系统，在Linux和mac中使用只要按官方文档来即可。
但是官方不支持windows操作系统，只是微软开源技术组织(Microsoft Open Tech group)在Github开发了一个win64的redis版本。

## 快速开始：

```
wget https://github.com/MSOpenTech/redis/releases/download/win-3.0.501/Redis-x64-3.0.501.zip #下载
rar x-t-o-p Redis-x64-2.8.2400.zip   #解压
cd Redis-x64-2.8.2400            #到redis目录
redis-server redis.windows.conf  #启动服务，需要先修改配置文件，要不然会出错
redis-cli -h ${ip} -p ${port}    #客户端连接，ip默认为127.0.0.1，port默认为6379
```

- 1,2步命令不一定可以使用，只是为了说明步骤；
- 3,4步必须要以管理员权限运行
- 以上只是为了说明快速开始的步骤，具体细节下面介绍。

## 下载安装

安装很简单，在[github上项目地址releases](https://github.com/MSOpenTech/redis/releases)
中找到合适的版本下载。

- 可以选择`.msi`格式的微软格式安装包,安装非常方便，双击根据提示下一步即可。可以选择添加到环境变量中，占用最大内存等。
- 如果下载`.zip`格式的压缩文件,最新3.0版本同样方便，只要解压缩即可。如需设置到环境变量需要自行设置。


## 运行服务端

我的电脑操作系统是64位win8.1，下载的redis版本是3.0.501。

```
# 以管理员身份运行cmd
C:\windows\system32>d:
D:\>cd "Program Files\Redis-x64-3.0.501"
D:\Program Files\Redis-x64-3.0.501>redis-server redis.windows.conf
                _._
           _.-``__ ''-._
      _.-``    `.  `_.  ''-._           Redis 3.0.501 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 15888
  `-._    `-._  `-./  _.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |           http://redis.io
  `-._    `-._`-.__.-'_.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |
  `-._    `-._`-.__.-'_.-'    _.-'
      `-._    `-.__.-'    _.-'
          `-._        _.-'
              `-.__.-'
			  
[15888] 01 Mar 23:17:05.883 # Server started, Redis version 3.0.501
[15888] 01 Mar 23:17:05.883 * DB loaded from disk: 0.000 seconds
[15888] 01 Mar 23:17:05.883 * The server is now ready to accept connections on p
ort 6379
```

## 客户端连接

```
# 以管理员身份运行cmd
#默认会连接本地6379端口的服务
C:\windows\system32>redis-cli    #redis安装路径已添加到环境变量中
127.0.0.1:6379> ping
PONG
127.0.0.1:6379>

#如果要指定ip和端口
C:\windows\system32>redis-cli -h ${your serve ip} -p ${port}
your server ip:port> ping
(error) ERR operation not permitted  #这个是因为设置了登录需要密码验证
your server ip:port> auth ${your password}
OK
your server ip:port> ping
PONG
your server ip:port>
```

## redis相关命令









