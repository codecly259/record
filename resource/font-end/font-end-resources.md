# ǰ����������

����һЩǰ�˳��õ�������Դ��һЩ����


## ����չʾ

- JSFiddle:[����](https://jsfiddle.net/)
- RunJS:[����](http://runjs.cn/)
- jsdo.it:[��������](http://jsdo.it)
- codepen:[��������](http://codepen.io/)
- jsbin:[��������](http://jsbin.com)

## style guide(���ָ��)

���¸����Եķ��ָ�Ͻ����ο���Ӧ�����Լ���һ�׷��
**��Ȼ���ŶӺ���ʱӦ�����������Ŷӵķ��**

- [github style guide](https://github.com/styleguide)
- [JavaScript Style Guide](https://github.com/airbnb/javascript)
- [jQuery��s Style Guides](http://contribute.jquery.org/style-guide/)
- [�ٶ�ǰ�˼���ѧԺ�淶](https://github.com/ecomfe/spec)  [��⹤��](http://fecs.baidu.com/)


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