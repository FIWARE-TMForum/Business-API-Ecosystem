#!/bin/bash

# Install basic dependencies
cd scripts
sudo ./resolve-basic-dep.sh
cd ..

# Setup env variables
export PATH=$PATH:/opt/biz-ecosystem/glassfish4/glassfish/bin
export PATH=$PATH:/opt/biz-ecosystem/node-v6.9.1-linux-x64/bin

echo 'export PATH=$PATH:/opt/biz-ecosystem/glassfish4/glassfish/bin' >> ~/.bashrc
echo 'export PATH=$PATH:/opt/biz-ecosystem/node-v6.9.1-linux-x64/bin' >> ~/.bashrc

sudo chown -R $USER:$USER /opt/biz-ecosystem

# Create directories
sudo mkdir /etc/default/rss
sudo chown $USER:$USER /etc/default/rss

asadmin start-domain
sudo service mysql restart
sudo service mongodb restart

