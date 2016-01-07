---
layout: post
title: java web项目使用CORS方法实现跨域请求方案
category : dialy
tagline: "use CORS to cross domain request"
tags : [java,ajax,cors]
---
{% include JB/setup %}

## 问题产生背景

需要实现这样一个需求，在当前站点中使用ajax发送一个请求到另一个站点获取数据。js中使用jquery的ajax如下：

```javascript
$.ajax({
     url:http://219.151.48.39:8085/kanms_appServer/operationer/login,
     data:{
     	"username": "test",
		"password": "test" 
     },
     type:'post',
     dataType:'json',
     success:function(data){
     	console.info(data);          	 
     });
```

结果在页面上出现以下错误提示：


```javascript
XMLHttpRequest cannot load http://219.151.48.39:8085/kanms_appServer/operationer/login. 
No 'Access-Control-Allow-Origin' header is present on the requested resource. 
Origin 'null' is therefore not allowed access.
```

## 问题分析
网上查询得知原来是因为跨域的问题，javascript出于安全方面的考虑，不允许跨域调用其他页面的对象。

> 什么是跨域？
> 简单的理解就是因为javascript同源策略的限制，a.com域名下的js无法操作b.com或者c.a.com域名下的对象。更详细的说明可以看下表：


|URL|说明 |是否允许通信
|------|------|-------
|http://www.a.com/a.js <br> http://www.a.com/b.js| 同一域名下| 允许
|http://www.a.com/lab/a.js <br> http://www.a.com/script/b.js| 同一域名下不同文件夹 | 允许
|http://www.a.com:8000/a.js <br> http://www.a.com/b.js | 同一域名不同端口| 不允许
|http://www.a.com/a.js <br> https://www.a.com/b.js | 同一域名不同协议 | 不允许
|http://www.a.com/a.js <br> http://70.32.92.74/b.js | 域名和域名对应ip | 不允许
|http://www.a.com/a.js <br> http://script.a.com/b.js | 主域相同，子域不同| 不允许
|http://www.a.com/a.js <br> http://a.com/b.js | 同一域名，不同二级域名（同上）| 不允许（cookie这种情况下也允许访问）
|http://www.cnblogs.com/a.js <br> http://www.a.com/b.js | 不同域名| 不允许

经分析得知js中`XMLHttpRequest`对象不能加载跨域上的资源

## 解决办法

那么，怎样才能解决跨域访问资源的问题呢，主要有`JSONP`、`flash`、`iframe`、`xhr2`。这里介绍使用`CORS`（跨域资源共享，Cross-Origin Resource Sharing）的方法。

> CORS原理：
> CORS定义一种跨域访问的机制，可以让AJAX实现跨域访问。CORS 允许一个域上的网络应用向另一个域提交跨域 AJAX 请求。实现此功能非常简单，只需由服务器发送一个响应标头即可。

做法为：设置HTTP响应头` Access-Control-Allow-Origin`，指定服务器端允许进行跨域资源访问的来源域。可以用通配符*表示允许任何域的JavaScript访问资源，但是在响应一个携带身份信息(Credential)的HTTP请求时，`Access-Control-Allow-Origin`必需指定具体的域，不能用通配符。 

这里使用Filter的方式给服务端的所有请求都加上` Access-Control-Allow-Origin`响应头，代码如下：
SimpleCORSFilter类

```java
package com.ustcinfo.kanms.support;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class SimpleCORSFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletResponse res = (HttpServletResponse)response;
		res.setHeader("Access-Control-Allow-Origin", "*");
		res.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		res.setHeader("Access-Control-Max-Age", "3600");
		res.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {

	}

}

```

web.xml中添加过滤器的配置

```xml
<!-- cors解决跨域访问问题 -->
<filter>
	<filter-name>cors</filter-name>
	<filter-class>com.ustcinfo.kanms.support.SimpleCORSFilter</filter-class>
</filter>
<filter-mapping>
	<filter-name>cors</filter-name>
	<url-pattern>/*</url-pattern>
</filter-mapping>
```

加上以上代码后，使用原来的ajax访问跨域服务端信息的`Response Header`如下：

```javascript
Access-Control-Allow-Headers:x-requested-with
Access-Control-Allow-Methods:POST, GET, OPTIONS, DELETE
Access-Control-Allow-Origin:*
Access-Control-Max-Age:3600
Content-Type:application/json;charset=UTF-8
Server:Jetty(8.1.10.v20130312)
Transfer-Encoding:chunked
```

并且可以通过ajax访问跨域服务器的资源了，大功告成。

## 更多阅读
1. [CORS维基百科](https://zh.wikipedia.org/wiki/%E8%B7%A8%E4%BE%86%E6%BA%90%E8%B3%87%E6%BA%90%E5%85%B1%E4%BA%AB)
2. [启用CORS实现Ajax跨域请求](http://www.web-fish.com/program/php/794.html)
3. [JavaScript跨域总结与解决办法](http://www.cnblogs.com/rainman/archive/2011/02/20/1959325.html)
4. [SpringMvc+AngularJS通过CORS实现跨域方案](http://www.tuicool.com/articles/umymmqY)