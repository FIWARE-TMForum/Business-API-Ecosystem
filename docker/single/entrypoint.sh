#!/usr/bin/env bash

################################## ENVIRONMENT VARIABLES NEEDED ############################

if [ -z $PAYPAL_CLIENT_ID ];
then
    echo PAYPAL_CLIENT_ID environment variable not set
    exit 1
fi

if [ -z $PAYPAL_CLIENT_SECRET ];
then
    echo PAYPAL_CLIENT_SECRET environment variable not set
    exit 1
fi

if [[ -z $MYSQL_ROOT_PASSWORD ]];
then
    echo MYSQL_ROOT_PASSWORD is not set
    exit 1
fi

if [[ -z $MYSQL_HOST ]];
then
    echo MYSQL_HOST is not set
    exit 1
fi

###############################################################################################

function test_connection {
    echo "Testing $1 connection"
    exec 10<>/dev/tcp/$2/$3
    STATUS=$?
    I=0

    while [[ ${STATUS} -ne 0  && ${I} -lt 50 ]]; do
        echo "Connection refused, retrying in 5 seconds..."
        sleep 5

        if [[ ${STATUS} -ne 0 ]]; then
            exec 10<>/dev/tcp/$2/$3
            STATUS=$?

        fi
        I=${I}+1
    done

    exec 10>&- # close output connection
    exec 10<&- # close input connection

    if [[ ${STATUS} -ne 0 ]]; then
        echo "It has not been possible to connect to $1"
        exit 1
    fi

    echo "$1 connection, OK"
}

function setup_charging {

    echo "Deploying Charging module"
    # Check that the settings files have been included
    if [ ! -f /business-ecosystem-charging-backend/src/user_settings/settings.py ]; then
        echo "Missing settings.py file"
        exit 1
    fi

    if [ ! -f /business-ecosystem-charging-backend/src/user_settings/services_settings.py ]; then
        echo "Missing services_settings.py file"
        exit 1
    fi

    if [ ! -f /business-ecosystem-charging-backend/src/user_settings/__init__.py ]; then
        touch /business-ecosystem-charging-backend/src/user_settings/__init__.py
    fi

    cd /business-ecosystem-charging-backend/src

    # Configure PayPal settings
    sed -i "s|PAYPAL_CLIENT_ID = ''|PAYPAL_CLIENT_ID = '$PAYPAL_CLIENT_ID'|g" ./wstore/charging_engine/payment_client/paypal_client.py
    sed -i "s|PAYPAL_CLIENT_SECRET = ''|PAYPAL_CLIENT_SECRET = '$PAYPAL_CLIENT_SECRET'|g" ./wstore/charging_engine/payment_client/paypal_client.py

    # Ensure mongodb is running
    # Get MongoDB host and port from settings
    MONGO_HOST=`grep -o "'HOST':.*" ./user_settings/settings.py | grep -o ": '.*'" | grep -oE "[^:' ]+"`

    if [ -z ${MONGO_HOST} ]; then
        MONGO_HOST=localhost
    fi

    MONGO_PORT=`grep -o "'PORT':.*" ./user_settings/settings.py | grep -o ": '.*'" | grep -oE "[^:' ]+"`

    if [ -z ${MONGO_PORT} ]; then
        MONGO_PORT=27017
    fi

    test_connection "MongoDB" ${MONGO_HOST} ${MONGO_PORT}

    # Check that the required APIs are running
    APIS_HOST=`grep "CATALOG =.*" ./user_settings/services_settings.py | grep -o "://.*:" | grep -oE "[^:/]+"`
    APIS_PORT=`grep "CATALOG =.*" ./user_settings/services_settings.py | grep -oE ":[0-9]+" | grep -oE "[^:/]+"`

    test_connection "APIs" ${APIS_HOST} ${APIS_PORT}

    # Check that the RSS is running
    RSS_HOST=`grep "RSS =.*" ./user_settings/services_settings.py | grep -o "://.*:" | grep -oE "[^:/]+"`
    RSS_PORT=`grep "RSS =.*" ./user_settings/services_settings.py | grep -oE ":[0-9]+" | grep -oE "[^:/]+"`

    test_connection "RSS" ${RSS_HOST} ${RSS_PORT}

    echo "Starting charging server"
    service apache2 restart

    cd /
    echo "Charging module deployed"
}

function setup_proxy {
    echo "Deploying logic proxy module"

    cd /business-ecosystem-logic-proxy
    # Get mongodb host and port from config file
    MONGO_HOST=`/business-ecosystem-logic-proxy/node-v6.9.1-linux-x64/bin/node getConfig mongohost`
    MONGO_PORT=`/business-ecosystem-logic-proxy/node-v6.9.1-linux-x64/bin/node getConfig mongoport`

    # Wait for mongodb to be running
    test_connection 'MongoDB' ${MONGO_HOST} ${MONGO_PORT}

    # Get glassfish host and port from config
    GLASSFISH_HOST=`/business-ecosystem-logic-proxy/node-v6.9.1-linux-x64/bin/node getConfig glasshost`
    GLASSFISH_PORT=`/business-ecosystem-logic-proxy/node-v6.9.1-linux-x64/bin/node getConfig glassport`

    # Wait for glassfish to be running
    test_connection 'Glassfish' ${GLASSFISH_HOST} ${GLASSFISH_PORT}

    # Wait for APIs to be deployed
    GLASSFISH_SCH=`/business-ecosystem-logic-proxy/node-v6.9.1-linux-x64/bin/node getConfig glassprot`
    GLASSFISH_PATH=`/business-ecosystem-logic-proxy/node-v6.9.1-linux-x64/bin/node getConfig glasspath`

    echo "Testing Glasfish APIs deployed"
    wget ${GLASSFISH_SCH}://${GLASSFISH_HOST}:${GLASSFISH_PORT}/${GLASSFISH_PATH}
    STATUS=$?
    I=0
    while [[ ${STATUS} -ne 0  && ${I} -lt 50 ]]; do
        echo "Glassfish APIs not deployed yet, retrying in 5 seconds..."

        sleep 5
        wget ${GLASSFISH_SCH}://${GLASSFISH_HOST}:${GLASSFISH_PORT}/${GLASSFISH_PATH}
        STATUS=$?

        I=${I}+1
    done

    # Include this setting to avoid inconsistencies between docker container port and used port
    sed -i "s|config\.port|config\.extPort|" /business-ecosystem-logic-proxy/lib/tmfUtils.js

    echo "Cleaning indexes"
    rm -rf ./indexes/*

    echo "Creating indexes..."
    /business-ecosystem-logic-proxy/node-v6.9.1-linux-x64/bin/node fill_indexes.js
    /business-ecosystem-logic-proxy/node-v6.9.1-linux-x64/bin/node collect_static.js

    cd ..
    echo "Logic proxy module deployed"
}

function setup_rss {
    echo "Deploying RSS module..."

    # Check if the properties files have been included
    if [ ! -f /etc/default/rss/oauth.properties ]; then
        echo "Missing oauth.properties file"
        exit 1
    fi

    if [ ! -f /etc/default/rss/database.properties ]; then
        echo "Missing database.properties file"
        exit 1
    fi

    # Get MySQL info
    MYSQL_RSS_HOST=`grep -o 'database\.url=.*' /etc/default/rss/database.properties | grep -oE '//.+:' | grep -oE '[^/:]+'`
    MYSQL_RSS_PORT=`grep -o 'database\.url=.*' /etc/default/rss/database.properties | grep -oE ':[0-9]+/' | grep -oE '[0-9]+'`

    test_connection "RSS MySQL" ${MYSQL_RSS_HOST} ${MYSQL_RSS_PORT}

    echo "Creating RSS database"
    mysql -u root --password=${MYSQL_ROOT_PASSWORD} -h ${MYSQL_RSS_HOST} --port=${MYSQL_RSS_PORT} -e "CREATE DATABASE IF NOT EXISTS RSS;"

    echo "Deploying RSS WAR file..."
    asadmin deploy --force true --contextroot DSRevenueSharing --name DSRevenueSharing /apis/business-ecosystem-rss/fiware-rss/target/DSRevenueSharing.war

    cp /apis/business-ecosystem-rss/fiware-rss/target/DSRevenueSharing.war /apis/wars-ext/
    echo "RSS module deployed"
}

function setup_apis {
    echo "Deploying TMF APIs..."
    cd /apis

    # Check MySQL connection for APIs
    test_connection "APIs MySQL" ${MYSQL_HOST} 3306

    echo "Creating Database tables"
    mysql -u root --password=${MYSQL_ROOT_PASSWORD} -h ${MYSQL_HOST} -e "CREATE DATABASE IF NOT EXISTS DSPRODUCTCATALOG2;"
    mysql -u root --password=${MYSQL_ROOT_PASSWORD} -h ${MYSQL_HOST} -e "CREATE DATABASE IF NOT EXISTS DSPRODUCTORDERING;"
    mysql -u root --password=${MYSQL_ROOT_PASSWORD} -h ${MYSQL_HOST} -e "CREATE DATABASE IF NOT EXISTS DSPRODUCTINVENTORY;"
    mysql -u root --password=${MYSQL_ROOT_PASSWORD} -h ${MYSQL_HOST} -e "CREATE DATABASE IF NOT EXISTS DSPARTYMANAGEMENT;"
    mysql -u root --password=${MYSQL_ROOT_PASSWORD} -h ${MYSQL_HOST} -e "CREATE DATABASE IF NOT EXISTS DSBILLINGMANAGEMENT;"
    mysql -u root --password=${MYSQL_ROOT_PASSWORD} -h ${MYSQL_HOST} -e "CREATE DATABASE IF NOT EXISTS DSCUSTOMER;"
    mysql -u root --password=${MYSQL_ROOT_PASSWORD} -h ${MYSQL_HOST} -e "CREATE DATABASE IF NOT EXISTS DSUSAGEMANAGEMENT;"

    test_connection "Glassfish" 127.0.0.1 4848

    python /apis-entrypoint.py

    cp /apis/wars/* /apis/wars-ext/
    cd ..

    echo "TMF APIs deployed"
}

########################################################################################

set -o monitor

export PATH=$PATH:/glassfish4/glassfish/bin
service mongodb start
asadmin start-domain

setup_apis
setup_rss
setup_charging
setup_proxy

cd /business-ecosystem-logic-proxy
/business-ecosystem-logic-proxy/node-v6.9.1-linux-x64/bin/node server.js
