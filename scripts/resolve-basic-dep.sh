#!/usr/bin/env bash

# Install python3 and pip3 required for executing install.py script
if [[ $DIST ==  "deb" ]]; then
    apt-get update
    apt-get install -y python3
    apt-get install -y python3-pip
    apt-get install unzip
elif [[  $DIST == "rhel" ]]; then
    yum -y install scl-utils
    rpm -Uvh https://www.softwarecollections.org/en/scls/rhscl/python33/epel-7-x86_64/download/rhscl-python33-epel-7-x86_64.noarch.rpm
    yum -y install python33
fi

pip3 install sh
pip3 install click

mkdir /opt/biz-ecosystem/

# Install APIs dependencies
./resolve-api-dep.sh

# Install charging backend dependencies
./resolve-charging-dep.sh

# Install proxy dependencies
./resolve-proxy-dep.sh