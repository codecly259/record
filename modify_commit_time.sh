# clear previous backup
rm -rf "$(git rev-parse --git-dir)/refs/original/"

commit="da5bd6629729bc2a51614d7f4536e1bd0ef6a7b9"
date=$(date -d '1 day ago')
git filter-branch --env-filter \
    "if [ \$GIT_COMMIT = '$commit' ]; then
         export GIT_AUTHOR_DATE='$date'
         export GIT_COMMITTER_DATE='$date'
         export GIT_COMMITTER_NAME="\$GIT_AUTHOR_NAME"
         export GIT_COMMITTER_EMAIL="\$GIT_AUTHOR_EMAIL"
     fi"