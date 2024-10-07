#!/bin/bash


sudo apt -y install nodejs --silent
sudo apt -y install npm --silent

echo "Installting dependencies..."
cd app
npm install  -y --silent


clear 