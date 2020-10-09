#!/bin/bash

## Public SSH key
mkdir -p /root/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYcUG2E2jBG7+xFUNd8UUdXOU+VGMmSniiRR7w9qD4smnaFdmCBI/ckNmgbW0iOkW24Sl5ZQPirtrZf6U//PLBZe3XsutDk39xsQouJ7+UWIWjJnhBrOY3iBT7Z3jqcvh8/K6ETlmjBCObv2lfARXyVlbLp0u4iMwVgVEbNevcn9Nblhpo8kYIwXJDBA2zhOBmrRp0RZABY2fEIWuKLG3t2/yHz7nh6kyt6/KmIFpGKiivG8l5Zh+6+nr1k0xwBbn7tecNNqg5OTEDY09q1ykW2AKOyFjE8CXzL+BF6P4yUdHBn8tRD5AftQKXCHd5h42Xa6RLZS9yNadKa0O4F0zv alex@Alexs-MacBook-Pro.local" > /root/.ssh/authorized_keys

## DNF Update
dnf update -y

## Check if a restart is required
if [[ $(dnf needs-restarting) ]]; then
    echo "Restart is needed Please restart and re-execute this script"
    exit
else
    echo "Restart is not needed."
fi

## Install python3
dnf install python3 python3-pip -y
## Install git
dnf install git -y

## Install ansible
git clone https://github.com/ansible/ansible.git /tmp/ansible
cd /tmp/ansible
pip3 install .
ansible --version
if [ $? -eq 0 ]
then
  echo "Successfully installed ansible"
else
  echo "Ansible not installed" >&2
fi

git clone https://github.com/alexnastas/loca-bootstrap.git /root/loca_bootstrap
cd /root/loca_bootstrap
ansible-galaxy install -r requirements.yml
ansible-playbook -i inventory provision.yml