docker run --rm -it -v $(pwd)/installer/playbooks:/playbooks -v $(pwd)/build:/playbooks/data -w /playbooks chrisdail/ansible:stable ansible-playbook -i /playbooks/data/inventory $@
