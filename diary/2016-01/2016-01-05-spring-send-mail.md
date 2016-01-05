---
layout: post
title: 使用spring发送邮件
category : dialy
tagline: "spring send mail"
tags : [spring,mail]
---
{% include JB/setup %}

本文主要介绍使用Spring3.x框架中的JavaMail支持来实现邮件发送功能，并添加附件。

1.需要用到的jar包：mail-1.4.jar,spring  
如果使用maven,pom.xml中添加依赖

```
<properties>
	<!-- 依赖公共包版本定义-->
	<log4j.version>1.2.14</log4j.version>
	<spring.version>3.1.0.RELEASE</spring.version>
</properties>
<dependency>
	<groupId>javax.mail</groupId>
	<artifactId>mail</artifactId>
	<version>1.4</version>
</dependency>
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-core</artifactId>
	<version>${spring.version}</version>
</dependency>
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-beans</artifactId>
	<version>${spring.version}</version>
</dependency>
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-context</artifactId>
	<version>${spring.version}</version>
</dependency>
```

2.spring-mail配置文件

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:task="http://www.springframework.org/schema/task"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd  
	http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-2.5.xsd
	http://www.springframework.org/schema/task http://www.springframework.org/schema/task/spring-task-3.0.xsd
	http://www.springframework.org/schema/context
    http://www.springframework.org/schema/context/spring-context-2.5.xsd"
	>
	<!-- 注意:这里的参数(如用户名、密码)都是针对邮件发送者的 -->
	<bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">
		<!-- SMTP发送邮件的服务器的IP和端口 -->
		<property name="host" value="${mail.host}" />
		<property name="port" value="${mail.port}" />

		<!-- 登陆SMTP邮件发送服务器的用户名和密码 -->
		<property name="username" value="${mail.username}" />
		<property name="password" value="${mail.password}" />

		<!-- 获得邮件会话属性,验证登录邮件服务器是否成功 -->
		<property name="javaMailProperties">
			<props>
				<prop key="mail.smtp.auth">true</prop>
				<prop key="prop">true</prop>
				<prop key="mail.smtp.timeout">25000</prop>
			</props>
		</property>
	</bean>

	<!-- 定时任务：每月2号发送邮件 corn:秒 分钟 小时 天(月) 月 天(星期) 年份 -->
	<task:scheduled-tasks>
		<task:scheduled ref="taskJob" method="sendMailJob" cron="0 0 0 2 * ? *" /> <!-- 每月2号的凌晨 -->
	</task:scheduled-tasks>

	<context:component-scan base-package="cn.com.starit.kanms.task" />

</beans>  
```
properties 文件配置

```
# 发送邮件配置
mail.host=smtp.163.com
mail.port=25
mail.username=maxinchun0215@163.com
mail.password=********
# 接收邮件的邮箱，多个用','分割
# 发送给
mail.to=maxinchun0215@qq.com,ma.xinchun@ustcinfo.com
# 抄送给
mail.copy=ha.chuanchi@ustcinfo.com,zhong.jinkai@ustcinfo.com
```

