#!/bin/bash

# Disable command echoing
set +x
sudo apt install nodejs
sudo apt install npm

echo "Installting dependencies..."
cd app
npm install


clear 