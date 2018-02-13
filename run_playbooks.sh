# !/bin/bash

# Desactivation de la vérification de la clef ssh
export ANSIBLE_HOST_KEY_CHECKING=False

# Execution des playbooks
ansible-playbook -i hosts_list --key-file ansible playbooks/install_compile_code.yml
ansible-playbook -i hosts_list --key-file ansible playbooks/install_execute.yml
ansible-playbook -i hosts_list --key-file ansible playbooks/install_publish_web.yml
ansible-playbook -i hosts_list --key-file ansible playbooks/install_web.yml

