#!/bin/bash
sudo yum update -y
sudo yum upgrade -y 
sudo yum install docker -y 
sudo yum install git -y 
sudo systemctl start docker
sudo usermod -aG docker ec2-user
git clone https://gitlab.com/TomiwaAribisala/node-project
cd node-project
docker build -t node-project:1.0
docker run --name node-project -p 3000:3000 node-project:1.0 -d 