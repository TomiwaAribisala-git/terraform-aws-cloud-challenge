#!/bin/bash
sudo yum update -y
sudo yum upgrade -y 
sudo yum install docker -y 
sudo yum install git -y 
sudo systemctl start docker
sudo usermod -aG docker ec2-user

git clone [repo]
cd nodejs-webapp
cd app
docker build -t nodejs-webapp:1.0
docker run --name nodejs-webapp -p 3000:3000 nodejs-webapp:1.0 -d 