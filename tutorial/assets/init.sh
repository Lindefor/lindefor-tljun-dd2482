#!/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/refs/heads/master/install.sh | bash 

source ~/.bashrc
nvm install 20 -y
nvm use 20 -y

cd app 
npm install
cd ..
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

minikube start --extra-config=kubeadm.ignore-preflight-errors=NumCPU --force --cpus=1

sudo apt update -y

snap install kubectl --classic

clear 