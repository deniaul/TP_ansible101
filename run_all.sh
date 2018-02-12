# !/bin/bash

git clone "https://github.com/mad97231/tp1_git" share

docker build -f Dockerfile -t compile_code:v1 compile_code/
docker build -f Dockerfile -t execute_code:v1 execute_code/
docker build -f Dockerfile -t git_stat:v1 git_stat/
docker build -f Dockerfile -t publish_stat:v1 publish_stat/

