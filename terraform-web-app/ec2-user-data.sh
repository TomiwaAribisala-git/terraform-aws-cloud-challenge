sudo yum update -y
sudo mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl enable amazon-ssm-agent
rm amazon-ssm-agent.deb
sudo yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
echo tomiwa97 | docker login -u dckr_pat_Oj0GFrJbkW9P672jNvOhIMasKOM --password-stdin
docker run -d -p 3000:3000 tomiwa97/node-project:latest