FROM ubuntu:16.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y ansible sshpass && \
    rm -rf /var/lib/apt/lists/*

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]