# Building an Enterise Product with Docker
## Presentation at Maritime Devcon 2016

This repo contains the slides for the talk I gave at Maritime Devcon 2016 (http://maritimedevcon.ca). The example I showed at the conference is located in the demo directory.

Slides are created with remark.js and can be viewed here: https://chrisdail.github.io/talk-product-with-docker

Contents of the Demo:

- ansible - Dockerfile for creating an ansible container. Existing ones I found lacked openssl or sshpass
- hello - Hello World simple service created as part of my talk from the previous year: https://github.com/chrisdail/talk-docker-microservices
- installer - A basic installation playbook showing installing docker containers using snaible to multiple nodes

To build:

```bash
./build.sh
```

To run (from demo/build):
```bash
./install.sh
```

Note that you will need to create an Ansible inventory file to run the installer.