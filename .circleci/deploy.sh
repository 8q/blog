#!/bin/bash

set -eu

DEPLOY_DIR=deploy

git config --global push.default simple
git config --global user.email $(git --no-pager show -s --format='%ae' HEAD)
git config --global user.name $CIRCLE_USERNAME
git clone -q --branch=gh-pages $CIRCLE_REPOSITORY_URL $DEPLOY_DIR

rm -rf $DEPLOY_DIR/*
cd $DEPLOY_DIR
mv ../public/* .
echo "blog.sayakachan.net" >> CNAME

git add -fA
git commit -m "Deploy #$CIRCLE_BUILD_NUM from CircleCI [ci skip]" || true
git push -f
