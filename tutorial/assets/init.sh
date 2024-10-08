#!/bin/bash

# Disable command echoing
set +x

echo "Installing dependencies..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/refs/heads/master/install.sh | bash >/dev/null 2>&1

source ~/.bashrc
nvm install 20 -y >/dev/null 2>&1

cd app
echo "Installing Node.js packages..."
npm install >/dev/null 2>&1
cd ..

echo "Installing Minikube... This could take a while"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 >/dev/null 2>&1
sudo install minikube-linux-amd64 /usr/local/bin/minikube >/dev/null 2>&1

echo "Adding Kubernetes apt key..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - >/dev/null 2>&1

echo "Adding Kubernetes repository..."
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list >/dev/null 2>&1

echo "Starting Minikube with specified configuration..."
minikube start --extra-config=kubeadm.ignore-preflight-errors=NumCPU --force --cpus=1 >/dev/null 2>&1

echo "Updating package list..."
sudo apt update -y >/dev/null 2>&1

echo "Installing kubectl..."
snap install kubectl --classic >/dev/null 2>&1

echo "Setup complete!"
