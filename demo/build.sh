docker pull nginx:1.9.15
docker pull golang:1.6.2-onbuild
docker pull registry:2
docker pull williamyeh/ansible:ubuntu16.04

docker build -t chrisdail/ansible:stable ansible/
docker build -t devcon/hello:1.0 hello/
docker build -t devcon/installer:1.0 playbooks/

# docker rmi $(docker images -q)

echo Saving images.tgz
mkdir build
docker save devcon/hello:1.0 nginx:1.9.15 devcon/installer:1.0 | gzip > build/images.tgz
cp install.sh build/
echo Done
