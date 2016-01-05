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

3.java类分别为

```java
package cn.com.starit.kanms.util.mail;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import cn.com.starit.commons.service.ApplicationContextProvider;
import cn.com.starit.commons.web.util.ExportUtil;
import cn.com.starit.kanms.dao.GridDao;
import cn.com.starit.kanms.service.DataSerive;
import cn.com.starit.kanms.util.CustomizedPropertyPlaceholderConfigurer;

import com.sun.xml.internal.messaging.saaj.packaging.mime.internet.MimeUtility;

/**
 * 发送邮件工具
 * 
 * @author maxinchun
 *
 */
public class SendMailUtil {
	private static Logger logger = Logger.getLogger(SendMailUtil.class);
	private static JavaMailSender sender;
	// 获取JavaMailSender bean
	static {
		if (sender == null) {
			sender = (JavaMailSender) ApplicationContextProvider.getBean("mailSender");
		}
	}


	/**
	 * 以附件形式发送email
	 * @param sendTo 收件人email地址
	 * @param copyTo 抄送对象的email地址
	 * @param mailSubject 邮件主题
	 * @param mailBody 内容
	 * @param files 附件
	 */
	public static void sendFileMail(String[] sendTo,String[] copyTo, String mailSubject, String mailBody, File[] files) {
		
		MimeMessage mimeMessage = sender.createMimeMessage();
		try {
			if(logger.isDebugEnabled()){
				logger.debug("带附件和图片的邮件正在发送...");
			}
			// 设置utf-8或GBK编码，否则邮件会有乱码
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage,true,"UTF-8");
			// 设置发送人名片
			String from = (String)CustomizedPropertyPlaceholderConfigurer.getContextProperty("mail.username");
			helper.setFrom(from);
			// 设置收件人邮箱
			helper.setTo(sendTo);
			if(copyTo.length != 0 && !copyTo[0].equals("")){
				helper.setCc(copyTo);
			}
			
			// 主题
			helper.setSubject(mailSubject);
			// 邮件内容，注意加参数true，表示启用html格式
			helper.setText(mailBody,true);
			
			if (files != null && files.length > 0) {
                for (int i = 0; i < files.length; i++)
                    // 加入附件
                    helper.addAttachment(MimeUtility.encodeText(files[i]
                            .getName()), files[i]);
            }
			 // 加入插图(图片附件)
//           helper.addInline(MimeUtility.encodeText("pic01"), new File("E:\\test\\slide-5.png"));
			
            sender.send(mimeMessage);
            logger.info("带附件和图片的邮件发送成功！");
		} catch (Exception e) {
			logger.info("带附件和图片的邮件发送失败！！！");
			e.printStackTrace();
		}
		
	}
	
	public static String createExecl(Long id) {
		GridDao gridDao = DataSerive.getGridDao();
		try {
			Map<String,Object> map = gridDao.getGridInfoByGridId(id);
			if(map !=null){
				String fileName = map.get("TITLE").toString();
				String columns = map.get("COLMN").toString();
				String sql = map.get("SQL").toString();
				List dataList = gridDao.getDataInfo(sql);
				String path = ExportUtil.createExcel(dataList, columns, fileName);
				return path;
			}else{
				logger.info("没有需要的导出数据,请查看girdId:【"+id+"】是否正确");
			}
		} catch (Exception e) {
			logger.info("生成excel失败！！！！");
			e.printStackTrace();
		}
		return "";
		
	}
	
	public static void main(String[] args) throws Exception {
		
		File noPay = new File(SendMailUtil.createExecl(143L));
		File toPay = new File(SendMailUtil.createExecl(142L));
		
//		File noPay = new File("E:\\test\\无交费记录接入点_20160105040144.xls");
//		File toPay = new File("E:\\test\\需要交费接入点_20160105050105.xls");
//		String to = "maxinchun0215@qq.com"; //ma.xinchun@ustcinfo.com
		String subject = "需要交费的接入点信息";
		String[] sendTo = CustomizedPropertyPlaceholderConfigurer.getContextProperty("mail.to").toString().split(",");
		String[] copyTo = CustomizedPropertyPlaceholderConfigurer.getContextProperty("mail.copy").toString().split(",");
		String body = "<html><head></head><body><h1>您好：</h1>&nbsp;&nbsp;附件为本月需要交费的接入点信息。其中，附件1为系统中暂时还<span style='color:red'>没有交费记录</span>的接入点信息；附件2为已超时但还<span style='color:red'>未交费</span>的接入点信息<br>提示：本邮件为系统每月自动发送</body></html>";
//		String body = "您好,附件为需要交费的接入点信息。其中，附件1为系统中暂时还没有交费记录的接入点信息；附件2为已超时但还未交费的接入点信息。请查收（提示：本邮件为每月自动发送）";
		File[] files = new File[]{noPay,toPay};
 		SendMailUtil.sendFileMail(sendTo, copyTo, subject, body, files);
	}
}

```