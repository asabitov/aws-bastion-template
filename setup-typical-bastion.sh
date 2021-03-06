#!/bin/bash

### Install essential software

yum -y install epel-release
yum -y install telnet strace tcpdump strace vim mc wget git curl jq bind-utils mariadb docker zip unzip whois

yum -y install https://centos7.iuscommunity.org/ius-release.rpm
yum -y install python36u python36u-pip


### Meta-data

INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')


### Install AWS CLI

pip3.6 install awscli --upgrade --user
export PATH=$PATH:/root/.local/bin/
sed -i 's/^PATH=$PATH:$HOME\/bin$/PATH=$PATH:$HOME\/bin:\/root\/.local\/bin/' ~/.bash_profile
aws configure set default.region $REGION


### Change host's name

BASTION_NAME=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" --region=$REGION --output=text | grep Name | cut -f5)

if [ -z "$BASTION_NAME" ]; then
  BASTION_NAME="bastion"
fi

hostnamectl set-hostname "$BASTION_NAME"

if ! grep preserve_hostname /etc/cloud/cloud.cfg; then
  echo "preserve_hostname: true" >> /etc/cloud/cloud.cfg
else
  sed -i 's/.*preserve_hostname:.*/preserve_hostname: true/' /etc/cloud/cloud.cfg
fi


### Keep SSH alive

sed -i 's/.*ClientAliveInterval.*/ClientAliveInterval 120/' /etc/ssh/sshd_config
sed -i 's/.*ClientAliveCountMax.*/ClientAliveCountMax 720/' /etc/ssh/sshd_config
systemctl restart sshd


### Create essential folders

mkdir -p /root/{git,tmp}


### Configure Git

git config --global push.default simple


### Enable Docker

groupadd docker
usermod -aG docker centos

systemctl enable docker
systemctl start docker


### Reboot

reboot 
