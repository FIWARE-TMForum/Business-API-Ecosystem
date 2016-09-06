#!/usr/bin/env bash

if [[ $DIST ==  "deb" ]]; then
    # Debian/Ubuntu
    echo "Debian/Ubuntu system"
    apt-get update
    apt-get install -y python python-pip
    apt-get install -y mongodb
    apt-get install -y wkhtmltopdf
    apt-get install -y xvfb
    # Install lxml dependencies
    apt-get install -y gcc
    apt-get install -y libxml2-dev libxslt1-dev zlib1g-dev python-dev libffi-dev libssl-dev

    # Install virtualenv
    pip install virtualenv

elif [[  $DIST == "rhel" ]]; then

    # Install python 2.7 which is required
    # Install dependencies
    yum groupinstall "Development tools"

    yum install -y  zlib-devel
    yum install -y bzip2-devel
    yum install -y openssl-devel
    yum install -y ncurses-devel
    yum install -y libffi-devel libssl-devel

    # Download and compile python 2.7
    if [[ $VER == "6" ]]; then
        cd /opt/biz-ecosystem/

        wget --no-check-certificate https://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
        tar xf Python-2.7.6.tar.xz
        cd Python-2.7.6
        ./configure --prefix=/usr/local --enable-shared
        make && make altinstall

        echo "/usr/local/lib" >> /etc/ld.so.conf
        /sbin/ldconfig

        # Install python 2.7 setup tools
        cd /opt
        wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
        /usr/local/bin/python2.7 ez_setup.py
        /usr/local/bin/easy_install-2.7 pip

        ln -s /usr/local/bin/python2.7 /usr/bin/python2.7
        ln -s /usr/local/bin/pip2.7 /usr/bin/pip2.7
    else
        rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
        yum -y update
        yum install -y python-pip
    fi

    yum install libxml2-devel libxslt-devel python-devel

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
    if [[ $VER == "7" ]]; then
        wget http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-centos7-amd64.rpm
        rpm -ivh wkhtmltox-0.12.1_linux-centos7-amd64.rpm
    else
        wget http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-centos6-amd64.rpm
        rpm -ivh wkhtmltox-0.12.1_linux-centos6-amd64.rpm
    fi

    yum install xorg-x11-server-Xvfb

    # Install virtualenv
    if [[ $VER == "6" ]]; then
        pip2.7 install virtualenv
    else
        pip install virtualenv
    fi
fi

cd $WORKSPACE