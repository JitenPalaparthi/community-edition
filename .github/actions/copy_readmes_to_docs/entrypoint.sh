#!/bin/sh -l

set -e
set -x

cd $GITHUB_WORKSPACE

git diff --name-only HEAD HEAD~1 | grep -i "/readme.md" > files

cat files | awk '{split($0,a,"/"); print "cp "$0" docs/site/content/docs/latest/"a[3]".md"}' >> cmds && chmod +x cmds && ./cmds

git config --global user.email "nseemiller@vmware.com"
git config --global user.name "nseemiller"
git add docs/site/content/docs/latest && git commit --message "add readme to docs" && git push
