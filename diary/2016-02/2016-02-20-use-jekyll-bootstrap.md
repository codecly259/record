---
layout: post
title: ����ʹ��jekyll bootstrap����
category : dialy
tagline: "jekyll bootstrap"
tags : [jekyll bootstrap]
---

���Ľ���jekyll�����jekyll-bootstrap����ľ�̬����

## ��������jekyll-bootstrap

> ������ȷ�ϱ����Ѱ�װ��jekyll��ػ���������git,ruby,rubygem,python,highlight,jekyll��

��github������jekyll-bootstrap��ʹ��jekyll��������

```sh
git clone https://github.com/plusjade/jekyll-bootstrap.git
cd jekyll-bootstrap
git remote set-url origin https://github/your_user_name/program_name(your_user_name.github.io)
git push origin master / git push origin gh-pages (program_name)
jekyll serve
```
�����м������url�ͷ����Ƿ�����github�ϵģ����Ǳ������б��롣 
�ɹ����������localhost:4000���ɷ��ʲ�����ҳ��

## jekyll-bootstrap����İ�װ��ѡ��

��������jekyll-bootstrap��Ĭ��ʹ��twitter���⣬������������
����ʹ��`rake`���ذ�װ���⡣

### ��װ����
> ����ȷ��rakeû�����⣬���ڰ�װ��ʱ��ͱ���`can not load file ...`��������û�а�װrake����ģ�顣
> ʹ��`gem install rake`���а�װ

#### ʹ��git��ַ��װ
```
rake theme:install git="https://github.com/jekyllbootstrap/theme-the-program.git"
```
��װ��ɺ����ʾ�Ƿ�ʹ�ô����⣬����`Y`�س�ʹ�ø����⡣

#### ����ѹ������װ
��������������Ĳ���ѹ��`./_theme_packages`Ŀ¼��
```
rake theme:install name="theme-name"
```

### �л�����
���ⰲװ��,Ҳ����ͨ��`rake`�����������л�
```
rake theme:switch name="the-program"
```

## �����Ķ�

- [jekyll �ٷ��ĵ�](http://jekyllrb.com/docs/home/)
- [bootstrap�����Ŷӷ����jekyll�ĵ�](http://jekyll.bootcss.com/docs/home/)
- [The Quickest Way to Blog on GitHub Pages](http://jekyllbootstrap.com/)
- [������վ��`Using Themes`����](http://jekyllbootstrap.com/usage/jekyll-theming.html)



