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

if [ -z $ADMIN_EMAIL ];
then
    echo ADMIN_EMAIL environment variable not set
    exit 1
fi

if [ -z $BIZ_ECOSYS_PORT ];
then
    echo BIZ_ECOSYS_PORT environment variable not set
    exit 1
fi

if [ -z $BIZ_ECOSYS_HOST ];
then
    echo BIZ_ECOSYS_HOST environment variable not set
    exit 1
fi

if [[ -z $OAUTH2_CLIENT_ID ]];
then
    echo OAUTH2_CLIENT_ID is not set
    exit 1
fi

if [[ -z $OAUTH2_CLIENT_SECRET ]];
then
    echo OAUTH2_CLIENT_SECRET is not set
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

############################################################################################

function create_tables {

    echo "Creating Database tables"
    mysql -u root --password=$MYSQL_ROOT_PASSWORD -h $MYSQL_HOST -e "CREATE DATABASE IF NOT EXISTS DSPRODUCTCATALOG2;"

    mysql -u root --password=$MYSQL_ROOT_PASSWORD -h $MYSQL_HOST -e "CREATE DATABASE IF NOT EXISTS DSPRODUCTORDERING;"

    mysql -u root --password=$MYSQL_ROOT_PASSWORD -h $MYSQL_HOST -e "CREATE DATABASE IF NOT EXISTS DSPRODUCTINVENTORY;"

    mysql -u root --password=$MYSQL_ROOT_PASSWORD -h $MYSQL_HOST -e "CREATE DATABASE IF NOT EXISTS DSPARTYMANAGEMENT;"

    mysql -u root --password=$MYSQL_ROOT_PASSWORD -h $MYSQL_HOST -e "CREATE DATABASE IF NOT EXISTS DSBILLINGMANAGEMENT;"

    mysql -u root --password=$MYSQL_ROOT_PASSWORD -h $MYSQL_HOST -e "CREATE DATABASE IF NOT EXISTS DSCUSTOMER;"

    mysql -u root --password=$MYSQL_ROOT_PASSWORD -h $MYSQL_HOST -e "CREATE DATABASE IF NOT EXISTS DSUSAGEMANAGEMENT;"

    mysql -u root --password=$MYSQL_ROOT_PASSWORD -h $MYSQL_HOST -e "CREATE DATABASE IF NOT EXISTS RSS;"
}

function glassfish_related {
    echo "Deploying APIs"
    python /apis-entrypoint.py
    python /rss-entrypoint.py
}

function done_mongo {

    cd business-ecosystem-charging-backend/src

    sed -i "s|PAYPAL_CLIENT_ID = ''|PAYPAL_CLIENT_ID = '$PAYPAL_CLIENT_ID'|g" ./wstore/charging_engine/payment_client/paypal_client.py

    sed -i "s|PAYPAL_CLIENT_SECRET = ''|PAYPAL_CLIENT_SECRET = '$PAYPAL_CLIENT_SECRET'|g" ./wstore/charging_engine/payment_client/paypal_client.py

    sed -i "s|WSTOREMAIL = 'wstore_email'|WSTOREMAIL = '$ADMIN_EMAIL'|g" ./settings.py

    if [[ ! -z $EMAIL_USER ]];
    then
        sed -i "s|WSTOREMAILUSER = 'email_user'|WSTOREMAILUSER = '$EMAIL_USER'|g" ./settings.py
    fi

    if [[ ! -z $EMAIL_PASSWD ]];
    then
        sed -i "s|WSTOREMAILPASS = 'wstore_email_passwd'|WSTOREMAILPASS = '$EMAIL_PASSWD'|g" ./settings.py
    fi

    if [[ ! -z $EMAIL_SERVER ]];
    then
        sed -i "s|SMTPSERVER = 'wstore_smtp_server'|SMTPSERVER = '$EMAIL_SERVER'|g" ./settings.py
    fi

    if [[ ! -z $EMAIL_SERVER_PORT ]];
    then
        sed -i "s|SMTPPORT = 587|SMTPPORT = $EMAIL_SERVER_PORT|g" ./settings.py
    fi

    sed -i "s|AUTHORIZE_SERVICE = 'http://localhost:8004/authorizeService/apiKeys'|AUTHORIZE_SERVICE = 'http://localhost:8000/authorizeService/apiKeys'|g" ./services_settings.py


    python ./manage.py createsite external http://$BIZ_ECOSYSTEM_HOST:$BIZ_ECOSYSTEM_PORT/
    python ./manage.py createsite internal http://127.0.0.1:8006/

    echo "Starting charging server"
    service apache2 restart

    cd ../../business-ecosystem-logic-proxy

    sed -i "s|config\.port|'$BIZ_ECOSYS_PORT'|" lib/tmfUtils.js
    python /proxy-entrypoint.py

    /node-v6.9.1-linux-x64/bin/node fill_indexes.js
    cd ..
}

########################################################################################

set -o monitor

export PATH=$PATH:/glassfish4/glassfish/bin

service mongodb start

asadmin start-domain

i=1

exec 8<>/dev/tcp/$MYSQL_HOST/3306
mysqlStatus=$?
doneTables=1

exec 9<>/dev/tcp/127.0.0.1/4848
glassfishStatus=$?
doneGlassfish=1

exec 10<>/dev/tcp/127.0.0.1/27017
mongodbStatus=$?
doneMongo=1

if [[ $mysqlStatus -eq 0 ]]; then
    create_tables
    doneTables=0
fi

if [[ $glassfishStatus -eq 0 && $mysqlStatus -eq 0 ]]; then
    glassfish_related
    doneGlassfish=0
fi

if [[ $mongodbStatus -eq 0 && $doneGlassfish -eq 0 ]]; then
    done_mongo
    doneMongo=0
fi


while [[ ($doneTables -ne 0 || $doneGlassfish -ne 0 || $doneMongo -ne 0) && $i -lt 50 ]]; do

    echo "Checking deployment status: "
    echo "MySQL databases: $doneTables"
    echo "API deployment: $doneGlassfish"
    echo "Charging startup: $doneMongo"

    sleep 5
    i=$i+1

    if [[ $mysqlStatus -eq 0 && $doneTables -eq 1 ]]; then
	    create_tables
	    doneTables=0

    elif [[ $mysqlStatus -ne 0 ]]; then
	    exec 8<>/dev/tcp/$MYSQL_HOST/3306
	    mysqlStatus=$?

    fi

    if [[ $glassfishStatus -eq 0 && $doneGlassfish -eq 1 && $mysqlStatus -eq 0 && $doneTables -eq 0 ]]; then
	    glassfish_related
	    doneGlassfish=0

    elif [[ $glassfishStatus -ne 0 ]]; then
	    exec 9<>/dev/tcp/127.0.0.1/4848
	    glassfishStatus=$?
    fi

    if [[ $mongodbStatus -eq 0 && $doneMongo -eq 1 && $glassfishStatus -eq 0 && $doneGlassfish -eq 0 ]]; then
	    done_mongo
	    doneMongo=0

    elif [[ $mongodbStatus -ne 0 ]]; then
	    exec 10<>/dev/tcp/127.0.0.1/27017
	    mongodbStatus=$?
    fi
done

if [[ $i -eq 50 ]];
then
    echo "It has not been possible to start the Business API Ecosystem due to a timeout waiting for a required service"
    echo Conection to Mongo returned $mongodbStatus
    echo Conection to MySQL returned $mysqlStatus
    echo Conection to Glassfish returned $glassfishStatus
    exit 1
fi


exec 8>&- # close output connection
exec 8<&- # close input connection
exec 9>&- # close output connection
exec 9<&- # close input connection
exec 10>&- # close output connection
exec 10<&- # close input connection

cd business-ecosystem-logic-proxy
/node-v6.9.1-linux-x64/bin/node server.js
