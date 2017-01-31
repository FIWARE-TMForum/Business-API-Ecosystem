#!/usr/bin/env bash


if [[ $DIST ==  "deb" ]]; then
    # Install Java
    if [[ $VER == "d" ]]; then
        echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
        echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
    else
        add-apt-repository -y ppa:webupd8team/java
    fi

    apt-get update
    apt-get install -y oracle-java8-installer
    apt-get install -y oracle-java8-set-default

    # Install MySQL
    apt-get install -y mysql-server mysql-client

    # Install maven
    apt-get install -y maven
elif [[  $DIST == "rhel" ]]; then
    # Install Java
    cd /opt/biz-ecosystem/
    wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz"

    tar xzf jdk-8u111-linux-x64.tar.gz

    alternatives --install /usr/bin/java java /opt/biz-ecosystem/jdk1.8.0_111/bin/java 2
    alternatives --config java

    alternatives --install /usr/bin/jar jar /opt/biz-ecosystem/jdk1.8.0_111/bin/jar 2
    alternatives --install /usr/bin/javac javac /opt/biz-ecosystem/jdk1.8.0_111/bin/javac 2
    alternatives --set jar /opt/biz-ecosystem/jdk1.8.0_111/bin/jar
    alternatives --set javac /opt/biz-ecosystem/jdk1.8.0_111/bin/javac

    # Install Mysql
    wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
    rpm -ivh mysql-community-release-el7-5.noarch.rpm
    yum update -y

    yum install -y mysql-community-server
    systemctl start mysqld
    mysql_secure_installation

    # Install maven
    wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
    sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
    yum install -y apache-maven
    yum install -y unzip
fi

# Install Glassfish
cd /opt/biz-ecosystem/

wget http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip
unzip glassfish-4.1.zip

# Deploy MySQL connector
wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.39.tar.gz

gunzip mysql-connector-java-5.1.39.tar.gz
tar -xvf mysql-connector-java-5.1.39.tar

cp mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar glassfish4/glassfish/lib

cd $WORKSPACE
