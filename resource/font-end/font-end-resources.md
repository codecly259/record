# 前端资料整理

整理一些前端常用的网络资源和一些链接


## 在线展示

- JSFiddle:[链接](https://jsfiddle.net/)
- RunJS:[链接](http://runjs.cn/)
- jsdo.it:[官网链接](http://jsdo.it)
- codepen:[官网链接](http://codepen.io/)
- jsbin:[官网链接](http://jsbin.com)

## style guide(风格指南)

以下各语言的风格指南仅供参考，应该有自己的一套风格。
**当然，团队合作时应该首先遵守团队的风格**

- [github style guide](https://github.com/styleguide)
- [JavaScript Style Guide](https://github.com/airbnb/javascript)
- [jQuery’s Style Guides](http://contribute.jquery.org/style-guide/)
- [百度前端技术学院规范](https://github.com/ecomfe/spec)  [检测工具](http://fecs.baidu.com/)


git filter-branch --commit-filter ' if [ "$GIT_AUTHOR_EMAIL" = "maxinchun0215@163.com" ]; then GIT_AUTHOR_NAME="codecly259"; GIT_AUTHOR_EMAIL="maxinchun0215@qq.com"; git commit-tree "$@"; else git commit-tree "$@"; fi' HEAD



git filter-branch --env-filter '
OLD_EMAIL="maxinchun0215@163.com"
CORRECT_NAME="codecly259"
CORRECT_EMAIL="maxinchun0215@qq.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags