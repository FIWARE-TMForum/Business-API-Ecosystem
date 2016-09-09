#!/usr/bin/env bash

if [[ $DIST ==  "deb" ]]; then
    # Debian/Ubuntu
    echo "Debian/Ubuntu system"
    apt-get update
    apt-get install -y python python-pip
    apt-get install -y mongodb
    apt-get install -y wkhtmltopdf
    apt-get install -y xvfb

    # Install virtualenv
    pip install virtualenv

elif [[  $DIST == "rhel" ]]; then

    # Install python 2.7 which is required
    # Install dependencies
    rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
    yum -y update
    yum install -y python-pip

    # Install MongoDB repository
    echo "[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1" > /etc/yum.repos.d/mongodb.repo

    yum install -y mongodb-org

    # Start mongodb
    service mongod start

    # Get wkhtmltopdf package download version 0.12.1
    wget http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-centos7-amd64.rpm
    rpm -ivh wkhtmltox-0.12.1_linux-centos7-amd64.rpm

    yum install xorg-x11-server-Xvfb

    # Install virtualenv
    pip install virtualenv
fi

cd $WORKSPACE