---
layout: post
title: 记一次查看tomcat日志文件的经历
category : dialy
tagline: "grep on tomcat catatlina.out"
tags : [tomcat,log,catalina.out]
---
{% include JB/setup %}

# 事件的起源
也就是个查询tocmat中日志的事情。之前的一个定时任务在本地测试没有问题，于是放到生产环境中，过段时间貌似没有产生预期的效果。
于是想查看日志看看到底有什么问题。然而，现在问题来了，生产环境中的日志全部打印在默认的文件中，即:`{$TOMCAT_HONME}/logs/catalina.out`
此文件已大量堆积到现在臃肿到几G的地步。偷偷的百度了下怎么查看文件大小：
```sh
ls -lh catalina.out

-rw-rw-r-- 1 kanms kanms 5.2G Feb  2 15:45 catalina.out
```
对，没有看错，**5.2G**!!!

# 事件的经历
- 首先找下是否有文件异常时自定义的一些打印日志,其中 -n 表示显示行号。
```sh
[kanms@kanms-web logs]$ grep -n "带附件和图片的邮件发送失败！！！" catalina.out
65393183:[kanms-eleManage]  『带附件和图片的邮件发送失败！！！』  (线程名：pool-8-thread-1) cn.com.starit.kanms.util.mail.SendMailUtil(SendMailUtil.java:81) 2016-02-02 00:00:02,616
65393215:[kanms-eleManage]  『带附件和图片的邮件发送失败！！！』  (线程名：pool-7-thread-1) cn.com.starit.kanms.util.mail.SendMailUtil(SendMailUtil.java:81) 2016-02-02 00:00:02,616
```
- 根据显示的信息及时间然后定位需要查看的日志内容，如查看上面第一次出现后的200行日志
```sh
sed -n "65393183,65393383p" catalina.out
[kanms-eleManage]  『带附件和图片的邮件发送失败！！！』  (线程名：pool-8-thread-1) cn.com.starit.kanms.util.mail.SendMailUtil(SendMailUtil.java:81) 2016-02-02 00:00:02,616
org.springframework.mail.MailSendException: Mail server connection failed; nested exception is javax.mail.MessagingException: Unknown SMTP host: mail.ustcinfo.com;
  nested exception is:
	java.net.UnknownHostException: mail.ustcinfo.com. Failed messages: javax.mail.MessagingException: Unknown SMTP host: mail.ustcinfo.com;
  nested exception is:
	java.net.UnknownHostException: mail.ustcinfo.com; message exception details (1) are:
Failed message 1:
javax.mail.MessagingException: Unknown SMTP host: mail.ustcinfo.com;
  nested exception is:
	java.net.UnknownHostException: mail.ustcinfo.com
	at com.sun.mail.smtp.SMTPTransport.openServer(SMTPTransport.java:1280)
	at com.sun.mail.smtp.SMTPTransport.protocolConnect(SMTPTransport.java:370)
	at javax.mail.Service.connect(Service.java:275)
	at org.springframework.mail.javamail.JavaMailSenderImpl.doSend(JavaMailSenderImpl.java:389)
	at org.springframework.mail.javamail.JavaMailSenderImpl.send(JavaMailSenderImpl.java:340)
	at org.springframework.mail.javamail.JavaMailSenderImpl.send(JavaMailSenderImpl.java:336)
	at cn.com.starit.kanms.util.mail.SendMailUtil.sendFileMail(SendMailUtil.java:78)
	at cn.com.starit.kanms.task.TaskJob.sendMailJob(TaskJob.java:27)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:606)
	at org.springframework.scheduling.support.ScheduledMethodRunnable.run(ScheduledMethodRunnable.java:64)
	at org.springframework.scheduling.support.DelegatingErrorHandlingRunnable.run(DelegatingErrorHandlingRunnable.java:53)
	at org.springframework.scheduling.concurrent.ReschedulingRunnable.run(ReschedulingRunnable.java:81)
	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:471)
	at java.util.concurrent.FutureTask.run(FutureTask.java:262)
	at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$201(ScheduledThreadPoolExecutor.java:178)
	at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:292)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1145)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:615)
	at java.lang.Thread.run(Thread.java:745)

```
- 通过日志发现原来是发送邮件服务器主机mail.ustcinfo.com不通的问题，但是本地使用同样的主机配置又试了一下可以发送
- 于是在服务器上ping服务器主机不通。
```sh
[kanms@kanms-web logs]$ ping mail.ustcinfo.com
ping: unknown host mail.ustcinfo.com
```
- 网上查阅之后才知道原来linux服务器上发送接收服务器需要安装sendmail包
- 安装后依然无效，可能是配置不正确，目前是把邮箱服务器由域名改成IP

# 事件后的思考

这里不把重点放在sendmail的安装与配置说明上，主要是提出日志的大小和分类上。  
目前的这种打印日志方式存在很多弊端，可以考虑按照以下方式进行修改：
- 按时间分类出文件。比如说一天一个文件，这个使用log4j等日志框架的配置文件即可实现
- 按照日志的级别进行分类出文件。比如ERROR以上的放在一个文件中；INFO级别的放一个文件；异常的放一个文件，这可以在输出的时候需要做处理
- 按日志内容进行分类。比如登录日志放在一个文件，操作某个重保的表格放一个文件等；这些需要在打印日志的时候注意分类，或者自定义一些常用的打印日志级别

以上的只是一些设想，具体以能够把日志明确分开和方便定位日志信息为准则，可以交叉使用上面的规则。