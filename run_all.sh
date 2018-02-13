# !/bin/bash

echo "Ajout de la cle publique et privee pour l'utilisation de l'user control\n"
chmod 600 ansible
ssh-add ansible

echo "Clonage du repository git contenant le TP1\n"

rm -rf share/ || true
git clone "https://github.com/mad97231/tp1_git" share
chmod 777 -R share/

echo "Suppression des contenaires existant\n"

docker kill $(docker ps -a -q -f name="contenaire")
docker rm $(docker ps -a -q -f name="contenaire")

echo "Creation des builds\n"

docker build -f compile_code/Dockerfile -t compile_code:v1 compile_code/
docker build -f execute_code/Dockerfile -t execute_code:v1 execute_code/
docker build -f git_stat/Dockerfile -t git_stat:v1 git_stat/
docker build -f publish_stat/Dockerfile -t publish_stat:v1 publish_stat/

echo "Lancement des contenaires\n"

docker run -d --name contenaire_compile -v `pwd`/share/:/opt compile_code:v1
docker run -d --name contenaire_execute -v `pwd`/share/:/opt execute_code:v1
docker run -d --name contenaire_git -v `pwd`/share/:/opt git_stat:v1 
docker run -d --name contenaire_publish -v `pwd`/share/:/opt publish_stat:v1

echo "Creation du fichier hosts_list\n"

echo "[compile]" > hosts_list
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' contenaire_compile >> hosts_list
echo "[execute]" >> hosts_list
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' contenaire_execute >> hosts_list
echo "[git]" >> hosts_list
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' contenaire_git >> hosts_list
echo "[publish]" >> hosts_list
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' contenaire_publish >> hosts_list

echo "Lancement script run_playbooks\n"
bash run_playbooks.sh

echo "Les statistiques GIT sont disponibles sur le serveur http: "
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' contenaire_publish
