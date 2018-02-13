# !/bin/bash

# Desactivation de la vérification de la clef ssh
export ANSIBLE_HOST_KEY_CHECKING=False

# Execution des playbooks
echo "Lancement de la compilation du code ..."
ansible-playbook -i hosts_list --key-file ansible playbooks/install_compile_code.yml

echo "Lancement de l'exécution du code ..."
ansible-playbook -i hosts_list --key-file ansible playbooks/install_execute.yml

echo "Génération des statistiques ..."
ansible-playbook -i hosts_list --key-file ansible playbooks/install_publish_web.yml

echo "Lancement du serveur web ..."
ansible-playbook -i hosts_list --key-file ansible playbooks/install_web.yml
