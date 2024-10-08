#!/bin/bash

# Disable command echoing
set +x

# Redirect all output to /dev/null, so only echo statements are printed
exec >/dev/null 2>&1

echo "Installing dependencies..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/refs/heads/master/install.sh | bash

source ~/.bashrc
nvm install 20 -y

cd app
echo "Installing Node.js packages..."
npm install
cd ..

echo "Installing Minikube... This could take a while"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo "Adding Kubernetes apt key..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "Adding Kubernetes repository..."
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "Starting Minikube with specified configuration..."
minikube start --extra-config=kubeadm.ignore-preflight-errors=NumCPU --force --cpus=1

echo "Updating package list..."
sudo apt update -y

echo "Installing kubectl..."
snap install kubectl --classic

echo "Setup complete!"
