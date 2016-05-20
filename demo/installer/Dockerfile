FROM chrisdail/ansible:stable

ADD playbooks /playbooks
WORKDIR /playbooks

CMD ansible-playbook -i /playbooks/data/inventory install.yml