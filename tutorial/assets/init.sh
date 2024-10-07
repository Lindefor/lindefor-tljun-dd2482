#!/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/refs/heads/master/install.sh | bash 

source ~/.bashrc
nvm install 20 -y
nvm use 20 -y

cd app 
npm install
cd ..
clear 
