#!/bin/bash

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

