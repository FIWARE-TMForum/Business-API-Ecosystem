#!/bin/bash

if [[ -z "$WORKSPACE" ]]
  then
    export WORKSPACE=`pwd`
fi

DIST=""
VER=""

if [ -f "/etc/centos-release" ]; then
    DIST="rhel"
    CONT=$(cat /etc/centos-release)

    if [[ $CONT == *7* ]]; then
        echo "7"
        VER="7"
    else
        VER="6"
    fi

elif [ -f "/etc/issue" ]; then
    # This file can exist in Debian and centos
    CONTENT=$(cat /etc/issue)

    if [[ $CONTENT == *CentOS* ]]; then
        DIST="rhel"
        VER="6"
    elif [[ $CONTENT == *Ubuntu* || $CONTENT == *Debian* ]]; then
        DIST="deb"
    fi
fi

# Install python3 and pip3 required for executing install.py script
if [[ $DIST ==  "deb" ]]; then
    apt-get update
    apt-get install -y python3
    apt-get install -y python3-pip
    apt-get install unzip
elif [[  $DIST == "rhel" ]]; then
    yum install python3 -y
    yum install python3-pip -y
    yum install unzip
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