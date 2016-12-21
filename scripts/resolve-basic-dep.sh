#!/usr/bin/env bash

if [[ -z "$WORKSPACE" ]]
  then
    export WORKSPACE=`pwd`
fi

# Install python3 and pip3 required for executing install.py script
if [[ $DIST ==  "deb" ]]; then
    apt-get update
    apt-get install -y python3
    apt-get install -y python3-pip
    apt-get install unzip
elif [[  $DIST == "rhel" ]]; then
    yum install -y centos-release-scl
    yum install -y python34
    curl -O https://bootstrap.pypa.io/get-pip.py
    sudo /usr/bin/python3.4 get-pip.py
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