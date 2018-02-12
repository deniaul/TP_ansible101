# !/bin/bash

echo "Clonage du repository git contenant le TP1"

git clone "https://github.com/mad97231/tp1_git" share

echo "Suppression des contenaires existant"

sudo docker kill $(sudo docker ps -a -q -f name="contenaire")
sudo docker rm $(sudo docker ps -a -q -f name="contenaire")

echo "Creation des builds"

docker build -f compile_code/Dockerfile -t compile_code:v1 compile_code/
docker build -f execute_code/Dockerfile -t execute_code:v1 execute_code/
docker build -f git_stat/Dockerfile -t git_stat:v1 git_stat/
docker build -f publish_stat/Dockerfile -t publish_stat:v1 publish_stat/

echo "Lancement des contenaires"

docker run -d --name contenaire_compile compile_code:v1
docker run -d --name contenaire_execute execute_code:v1
docker run -d --name contenaire_git git_stat:v1
docker run -d --name contenaire_publish publish_stat:v1

#docker run --rm -ti --name compile_code -v 'pwd'share/code/:/opt/code compile_code:v1
#docker run --rm -ti --name execute_code -v 'pwd'share/code/:/opt/code execute_code:v1
#docker run --rm -ti --name git_stat -v 'pwd'share/code/:/opt/code git_stat:v1
#docker run --rm -ti --name publish_stat -v 'pwd'share/code/:/opt/code publish_stat:v1

