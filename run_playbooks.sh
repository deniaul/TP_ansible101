# !/bin/bash 

echo "Lancement de la compilation du code ..."
ansible-playbook -i hosts_list playbooks/install_compile_code.yml

echo "Lancement de l'exécution du code ..."
ansible-playbook -i hosts_list playbooks/install_compile_code.yml

echo "Génération des statistques ..."
 
