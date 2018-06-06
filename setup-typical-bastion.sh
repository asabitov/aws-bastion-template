#!/bin/bash

yum -y install epel-release
yum -y install strace tcpdump strace vim mc wget git curl jq bind-utils
yum -y install python34 python34-pip

pip3 install awscli --upgrade --user
export PATH=$PATH:/root/.local/bin/
sed -i 's/^PATH=$PATH:$HOME\/bin$/PATH=$PATH:$HOME\/bin:\/root\/.local\/bin/' ~/.bash_profile

INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')

BASTION_NAME=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" --region=$REGION --output=text | cut -f5)

if [ -z $BASTION_NAME ]; then
  BASTION_NAME="bastion"
fi  

hostnamectl set-hostname --static $BASTION_NAME

if ! grep preserve_hostname /etc/cloud/cloud.cfg; then
  echo "preserve_hostname: true" >> /etc/cloud/cloud.cfg
else
  sed -i 's/.*preserve_hostname:.*/preserve_hostname: true/' /etc/cloud/cloud.cfg
fi 

mkdir -p /root/{git,tmp}

git config --global push.default simple

echo "Please don't forget to reboot!" 
