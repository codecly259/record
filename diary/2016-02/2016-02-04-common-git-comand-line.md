---
layout: post
title: 一些常用的git命令
category : dialy
tagline: "common git command line"
tags : [git]
---

一些常用的git命令行

```sh
git add .
git commin -m "udpate describe"
git commit -a -m "update describe"

git status
git push origin master

git checkout --file                 # 撤销工作区的更改
git reset --head [commit hashcode]  # 回退到某个提交时的状态
git push --force                    # 强制提交到远程仓库
```