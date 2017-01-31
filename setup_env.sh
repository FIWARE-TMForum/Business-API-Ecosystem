#!/bin/bash

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

# Install basic dependencies
cd scripts
sudo -E ./resolve-basic-dep.sh
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

/opt/biz-ecosystem/glassfish4/glassfish/bin/asadmin start-domain

if [[ $DIST ==  "deb" ]]; then
    sudo service mysql restart
    sudo service mongodb restart
elif [[  $DIST == "rhel" ]]; then
    sudo service mysqld restart
    sudo service mongod restart
fi


