#!/usr/bin/env bash

if [[ -z "$WORKSPACE" ]]
  then
    export WORKSPACE=`pwd`
fi

if [ -f "/etc/centos-release" ]; then
    export DIST="rhel"
    CONT=$(cat /etc/centos-release)

    if [[ $CONT == *7* ]]; then
        echo "7"
        export VER="7"
    else
        export VER="6"
    fi

elif [ -f "/etc/issue" ]; then
    # This file can exist in Debian and centos
    CONTENT=$(cat /etc/issue)

    if [[ $CONTENT == *CentOS* ]]; then
        export DIST="rhel"
        export VER="6"
    elif [[ $CONTENT == *Ubuntu* || $CONTENT == *Debian* ]]; then
        export DIST="deb"
        if [[ $CONTENT == *Debian* ]]; then
            export VER="d"
        fi
    fi
fi

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