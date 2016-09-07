#!/usr/bin/env bash

# Install Java
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install -y oracle-java8-installer
apt-get install -y oracle-java8-set-default

# Install Glassfish
cd /opt/biz-ecosystem/

wget http://download.java.net/glassfish/4.1.1/release/glassfish-4.1.1.zip
unzip glassfish-4.1.1.zip

# Install MySQL
apt-get install mysql-server mysql-client

# Deploy MySQL connector
wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.39.tar.gz

gunzip mysql-connector-java-5.1.39.tar.gz
tar -xvf mysql-connector-java-5.1.39.tar

cp mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar glassfish4/glassfish/lib

# Install maven
apt-get install -y maven

cd $WORKSPACE