name: heading
layout: true
class: center, middle, inverse

---

# Building an Enterprise Product with Docker

## Maritime Devcon 2016
Chris Dail - [@chrisdail](http://twitter.com/chrisdail)

Director, Software Engineering at [EMC](http://www.emc.com)

---

layout: false

# Intro

Talk about my experience building an enterprise product with docker
- Lessons Learned
- Case Study
- How-To

--

"We" means the product team I work with

---

# Rewind, Maritime Devcon 2015

- Advantages of Microservices architecture
- Basics of Docker to achieve this architecture

---

template: heading
## Microservices

---

template: heading
## Typically Seen in Software as a Service

Common architecture for "Cloud Services"

---

template: heading
![Y U NO](images/docker-allthings.jpg)
## What About Enterprise Products

How to use microservices and docker for packaged products?

---

template: heading
![Y U NO](images/yuno-saas.jpg)
## Why Packaged Product?

To understand this, you need to understand what we built

---

# What We Built

- A Turnkey Private Cloud based on OpenStack
- Infrastructure: Hardware and Software
- Self-contained: Network switches, Compute servers with Storage (Hyper-converged)

---

template:heading
# Challenges for Self-Contained Enterprise Products

---

.left-column[
## Challenges
### - N different environments
]
.right-column[
- Multiple Customer Installation Sites
- Different Versions at Different Sites
--
- Robust Installation and Upgrade becomes important
]

---

.left-column[
## Challenges
### - N different environments
### - Dark Sites
]
.right-column[
- Limited or no Internet Access (Security Reasons)
- Trusted Sites - Anything you need coming from a site you control (HTTPS)
  - OS Package Updates, etc
]

---

.left-column[
## Challenges
### - N different environments
### - Dark Sites
### - No Dependencies
]
.right-column[
- Assume as little as possible about a customer environment
- Cannot depend on customer's private cloud or AWS
]

---

.left-column[
## Challenges
### - N different environments
### - Dark Sites
### - No Dependencies
### - Legal
]
.right-column[
- This is easy
```bash
docker run -v /data:/usr/share/nginx/html:ro -d nginx
```
- You are including more than just 'nginx' here
  - This image is based on debian
- Licensing wise you may be shipping a lot more packages than you intend
]

---

# Common Base Image

- Docker images always have a base linux distribution
- Use a standard one (debian, ubuntu) or create your own
- All containers build off your base
  - Docker does not repeat layers -- Less disk space
  - Worry about supporting a single linux flavor for all containers

---

# Packaging

- Need a way to 'deliver' the software product
  - Installation
  - Upgrade
- How can you package a product based on docker?

---

# Docker Hub

- Public 'Docker Registry'
  - You are making your image 'public'
- Depending on docker.com to keep this up

![Docker Hub](images/docker-hub.png)

---

# Private Docker Registry

- Run your own registry
- Docker's Registry
```bash
docker run -d -p 5000:5000 --name registry registry:2
```
- Third-party commercial options
- You still require internet access

---

# Docker Save

- Export docker images in a single tarball
- Does not repeat layers
```bash
docker save \
    foo/installer:1.0 \ 
    foo/upgrade:1.0 \
    foo/inventory:1.0 \
    foo/discovery:1.0 \
    foo/persistence:1.0 \
    foo/ui:1.0 \
    | gzip > images.tgz
```

---

# Installation

Installer included as part of packaged images. Installation is:
1. Load docker images
2. Start installation docker image
```bash
docker load < images.tgz
docker run foo/installer:1.0
```

---

# Distributing Images

- Docker images still only on one node
- How to get to other nodes?

---

# Docker Registry

- Installation wide, private docker registry
- Installer loads all docker images into registry
- `docker run` on any node can load any container

---

# Docker Registry Issues

- Not a great HA story requires S3 Storage
  - Public storage for a private server?
  - Chicken/Egg Issue
- Cannot upload a collection of images (images.tgz)
  - One at a time
- `docker push` is very slow

---

# Docker Orchestration
- Lots of different docker 'orchestration' options
  - Mesos + Marathon
  - Kubernetes
  - Docker Swarm
  - CoreOS, Maestro, Helios
- Evaluated these ~18 months ago

---

# Platform as a Service

- Both Mesos and Kubernetes are awesome
- Lacking in key areas like upgrade
- Platform requires setup, lots of dependencies
  - Makes it hard to use as foundation to build other platforms

---

# Native - Docker Swarm

- Little more than a blog post when we looked at it
- Matured a lot over the last year
- More 'Simple' approach
- Not a full PaaS
- Would likely use for a new project

---

# Traditional Orchestration

- Vanilla Docker is pretty good
- Just need something that can call the docker CLI/API on each node
- Traditional Options:
  - Chef
  - Puppet
  - SaltStack
  - Ansible
  
---

# Ansible

- We opted to use Ansible+docker for orchestration needs
- Advantages
  - Great docker support (better than the others)
  - Agentless (orchestration over SSH)
  - Growing popularity for working with Docker
- Disadvantages
  - Smaller/newer community
  - GPLv3 is trickier for licensing
???
go into details with inventory
integrating with Ansible? Bedrock?
examples?

---

# Installer

- Docker container with Ansible
- Installation playbooks to install containers on different nodes

---

# Upgrade

- Very important to enterprise products
- Remember, many customers running many versions
- If upgrade is easy, more customers will upgrade
  - Fewer old versions
  - Easier Support

---

# Upgrade

- Same package as installation (images.tgz)
- Upgrade using Ansible Playbooks
  - Container Replace (Patch)
  - Add/Remove new containers
  - Data Migrations
- Actually much more complicated than this :)

---

# Demo

- Productize last year's demo
- Install to multiple nodes

---

template: heading
# Questions?
