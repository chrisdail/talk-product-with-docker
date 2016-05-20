echo docker load
docker load < images.tgz
echo docker run devcon/installer:1.0
docker run --rm -it -v $(pwd):/playbooks/data devcon/installer:1.0