---
layout: post
title: 快速使用jekyll bootstrap主题
category : dialy
tagline: "jekyll bootstrap"
tags : [jekyll bootstrap]
---

本文介绍jekyll搭建基于jekyll-bootstrap主题的静态博客

## 本地运行jekyll-bootstrap

> 首先请确认本地已安装好jekyll相关环境：包括git,ruby,rubygem,python,highlight,jekyll等

在github上下载jekyll-bootstrap并使用jekyll本地运行

```sh
git clone https://github.com/plusjade/jekyll-bootstrap.git
cd jekyll-bootstrap
git remote set-url origin https://github/your_user_name/program_name(your_user_name.github.io)
git push origin master / git push origin gh-pages (program_name)
jekyll serve
```
其中中间的设置url和发布是发布到github上的，不是本地运行必须。 
成功启动后访问localhost:4000即可访问博客主页。

## jekyll-bootstrap主题的安装和选择

以上启动jekyll-bootstrap是默认使用twitter主题，如果想更改主题
可以使用`rake`下载安装主题。

### 安装主题
> 首先确认rake没有问题，我在安装的时候就报错`can not load file ...`，经查找没有安装rake编译模块。
> 使用`gem install rake`进行安装

#### 使用git地址安装
```
rake theme:install git="https://github.com/jekyllbootstrap/theme-the-program.git"
```
安装完成后会提示是否使用此主题，输入`Y`回车使用该主题。

#### 下载压缩包后安装
在网上下载主题的并解压到`./_theme_packages`目录下
```
rake theme:install name="theme-name"
```

### 切换主题
主题安装后,也可以通过`rake`在主题间进行切换
```
rake theme:switch name="the-program"
```

## 更多阅读

- [jekyll 官方文档](http://jekyllrb.com/docs/home/)
- [bootstrap中文团队翻译的jekyll文档](http://jekyll.bootcss.com/docs/home/)
- [The Quickest Way to Blog on GitHub Pages](http://jekyllbootstrap.com/)
- [上面网站的`Using Themes`部分](http://jekyllbootstrap.com/usage/jekyll-theming.html)



