#!/bin/bash

cat config-user/profile > ~/.profile
cat config-user/xprofile > ~/.xprofile

mkdir -p ~/.ssh/
cat config-user/ssh > ~/.ssh/config

ssh-keygen -f ~/.ssh/github -C "$EMAIL"
ssh-keygen -f ~/.ssh/gitlab -C "$EMAIL"