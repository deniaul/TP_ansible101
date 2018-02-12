# !/bin/bash

git clone "https://github.com/mad97231/tp1_git" share

docker build -f Dockerfile -t compile_code:v1 compile_code/
docker build -f Dockerfile -t execute_code:v1 execute_code/
docker build -f Dockerfile -t git_stat:v1 git_stat/
docker build -f Dockerfile -t publish_stat:v1 publish_stat/

docker run --rm -ti --name compile_code -v 'pwd'/share/code/:/opt/code compile_code:v1
docker run --rm -ti --name execute_code -v 'pwd'/share/code/:/opt/code excute_code:v1
docker run --rm -ti --name git_stat -v 'pwd'/share/code/:/opt/code git_stat:v1
docker run --rm -ti --name publish_stat -v 'pwd'/share/code/:/opt/code publish_stat:v1

