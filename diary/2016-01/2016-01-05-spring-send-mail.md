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

2.