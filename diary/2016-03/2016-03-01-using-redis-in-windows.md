---
layout: post
title: ��windows����ϵͳ��ʹ��redis
description: redis�ٷ�֧����unix��linux��mac��ϵͳ����Linux��mac��ʹ��ֻҪ���ٷ��ĵ������ɡ����ǹٷ���֧��windows����ϵͳ��ֻ��΢��Դ������֯()Microsoft Open Tech group)��Github������һ��win64��redis�汾��
category: technology
tags: [windows,redis]
---
{% include JB/setup %}

redis�ٷ���֧��windowsϵͳ�������ϵ�����Ϊ��

>The Redis project does not officially support Windows. However, the Microsoft Open Tech group develops and maintains this Windows port targeting Win64

����Ϊ��redis�ٷ��ǲ�֧��windows�ġ����ǣ�΢��Դ������֯Ϊwin64�û�������ά�����windows�汾��Ҫ�˽���࣬�뿴[��Ŀ��ַ](https://github.com/MSOpenTech/redis)

redis�ٷ�֧����unix��linux��mac��ϵͳ����Linux��mac��ʹ��ֻҪ���ٷ��ĵ������ɡ�
���ǹٷ���֧��windows����ϵͳ��ֻ��΢��Դ������֯()Microsoft Open Tech group)��Github������һ��win64��redis�汾��

# ���ٿ�ʼ��

```
wget https://github.com/MSOpenTech/redis/releases/download/win-2.8.2400/Redis-x64-2.8.2400.zip #���أ����һ�����ã�ֻ��Ϊ��˵��Ҫ�����ļ�
rar x-t-o-p Redis-x64-2.8.2400.zip   #��ѹ�����һ�����ã�ֻ��Ϊ��˵����Ҫ��ѹ
cd Redis-x64-2.8.2400            #��redisĿ¼
redis-server redis.windows.conf  #����������Ҫ���޸������ļ���Ҫ��Ȼ�����
redis-cli -h ${ip} -p ${port}    #�ͻ������ӣ�ipĬ��Ϊ127.0.0.1��portĬ��Ϊ6379
```

- 1,2�����һ������ʹ�ã�ֻ��Ϊ��˵�����裻
- 3,4������Ҫ�Թ���ԱȨ������
- ����ֻ��Ϊ��˵�����ٿ�ʼ�Ĳ��裬����ϸ��������ܡ�

## ��װ




