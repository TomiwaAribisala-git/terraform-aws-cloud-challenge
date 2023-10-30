yum update -y
yum install docker -y
systemctl enable docker
systemctl start docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user
echo tomiwa97 | docker login -u dckr_pat_Oj0GFrJbkW9P672jNvOhIMasKOM --password-stdin
docker run -d -p 3000:3000 tomiwa97/node-project:latest