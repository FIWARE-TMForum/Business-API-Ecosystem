# Business API Ecosystem Docker Image

The [Business API Ecosystem](https://github.com/FIWARE-TMForum/Business-API-Ecosystem) can be deployed with Docker using
two different approaches. On the one hand, for all the components that made up the Business API Ecosystem it has been 
provided a Docker image that can be used jointly with `docker-compose` in order to deploy and configure the ecosystem.
On the other hand, this repo includes a single Docker image which already includes all the different Business API Ecosystem
modules.

The Business API Ecosystem requires instances of MySQL and MongoDB running. In this regard, you have three possibilities:
* You can have your own instances deployed in your machine
* You can manually run docker containers before executing the Business API Ecosystem
* You can use docker-compose to automatically deploy both components

## OAuth2 Authentication

The Business API Ecosystem authenticates with the [FIWARE identity manager](http://fiware-idm.readthedocs.io/en/latest/). In this regard, it is needed to register an application in this portal in order to acquire the OAuth2 credentials.

There you have to use the following info for registering the app:
* Name: The name you want for your instance
* URL: Host and port where you plan to run the instance. http|https://host:port/
* Callback URL: URL to be called in the OAuth process. http|https://host:port/auth/fiware/callback

## BAE Deployment

### BAE Modules Images

As stated, it is possible to deploy the Business API Ecosystem using the Docker images available for each of the BAE
modules with `docker-compose`. In particular, the following images have to be deployed:

* [biz-ecosystem-apis](https://hub.docker.com/r/conwetlab/biz-ecosystem-apis/): Image including the TMForum APIs
* [biz-ecosystem-rss](https://hub.docker.com/r/conwetlab/biz-ecosystem-rss/): Image Including the RSS module
* [biz-ecosystem-charging-backend](https://hub.docker.com/r/conwetlab/biz-ecosystem-charging-backend/): Image including the charging backend module
* [biz-ecosystem-logic-proxy](https://hub.docker.com/r/conwetlab/biz-ecosystem-logic-proxy/): Image including the logic proxy module

For deploying the BAE using this method the first step is creating a `docker-compose.yml` file with the following contents:

```
version: '3'
services:
    mongo:
        image: mongo:3.2
        restart: always
        ports:
            - 27019:27017
        networks:
            main:
        volumes:
            - ./mongo-data:/data/db

    mysql:
        image: mysql:latest
        restart: always
        ports:
            - 3333:3306
        volumes:
            - ./mysql-data:/var/lib/mysql
        networks:
            main:
        environment:
            - MYSQL_ROOT_PASSWORD=my-secret-pw
            - MYSQL_DATABASE=RSS

    charging:
        image: conwetlab/biz-ecosystem-charging-backend:develop
        restart: always
        links:
            - mongo
        depends_on:
            - mongo
            - apis
            - rss
        ports:
            - 8006:8006
        networks:
            main:
                aliases:
                    - charging.docker
        volumes:
            - ./charging-bills:/business-ecosystem-charging-backend/src/media/bills
            - ./charging-assets:/business-ecosystem-charging-backend/src/media/assets
            - ./charging-plugins:/business-ecosystem-charging-backend/src/plugins
            - ./charging-settings:/business-ecosystem-charging-backend/src/user_settings
            - ./charging-inst-plugins:/business-ecosystem-charging-backend/src/wstore/asset_manager/resource_plugins/plugins
        environment:
          - PAYPAL_CLIENT_ID=client_id
          - PAYPAL_CLIENT_SECRET=client_secret

    proxy:
        image: conwetlab/biz-ecosystem-logic-proxy:develop
        restart: always
        links:
            - mongo
        depends_on:
            - mongo
            - apis
        ports:
            - 8004:8000
        networks:
            main:
                aliases:
                    - proxy.docker
        volumes:
            - ./proxy-conf:/business-ecosystem-logic-proxy/etc
            - ./proxy-indexes:/business-ecosystem-logic-proxy/indexes
            - ./proxy-themes:/business-ecosystem-logic-proxy/themes
            - ./proxy-static:/business-ecosystem-logic-proxy/static
        environment:
            - NODE_ENV=production

    apis:
        image: conwetlab/biz-ecosystem-apis:develop
        restart: always
        ports:
            - 4848:4848
            - 8080:8080
        links:
            - mysql
        depends_on:
            - mysql
        networks:
            main:
                aliases:
                    - apis.docker
        environment:
            - MYSQL_ROOT_PASSWORD=my-secret-pw
            - MYSQL_HOST=mysql

    rss:
        image: conwetlab/biz-ecosystem-rss:develop
        restart: always
        ports:
            - 9999:8080
            - 4444:4848
            - 1111:8181
        links:
            - mysql
        depends_on:
            - mysql
        networks:
            main:
                aliases:
                    - rss.docker
        volumes:
            - ./rss-conf:/etc/default/rss

networks:
    main:
        external: true

```

The next step is providing all the configuration files required by the different components using the configured volumes.
It is possible to find valid configuration files (as well as the `docker-compose.yml`) in the [GitHub repo of the BAE](https://github.com/FIWARE-TMForum/Business-API-Ecosystem)

As you can see, the different modules include environment variables and volumes. In particular:

**Charging**

The biz-ecosystem-charging-backend needs the following environment variables:
* **PAYPAL_CLIENT_ID**: the client id of your application PayPal credentials used for charging users (a Sandbox account can be used for testing).
* **PAYPAL_CLIENT_SECRET**: the client secret of your application PayPal credentials used for charging users (a Sandbox account can be used for testing).

Additionally, the biz-ecosystem-charging-backend image contains 5 volumes. In particular:
* */business-ecosystem-charging-backend/src/media/bills*: This directory contains the PDF invoices generated by the Business Ecosystem Charging Backend
* */business-ecosystem-charging-backend/src/media/assets*: This directory contains the different digital assets uploaded by sellers to the Business Ecosystem Charging Backend
* */business-ecosystem-charging-backend/src/plugins*: This directory is used for providing asset plugins (see section *Installing Asset Plugins*)
* */business-ecosystem-charging-backend/src/user_settings*: This directory must include the *settings.py* and *services_settings.py* files with the software configuration.
* */business-ecosystem-charging-backend/src/wstore/asset_manager/resource_plugins/plugins*: This directory includes the code of the plugins already installed

**Proxy**

The biz-ecosystem-logic-proxy image contains 4 volumes. In particular:
* */business-ecosystem-logic-proxy/etc*: This directory must include the `config.js` file with the software configuration
* */business-ecosystem-logic-proxy/indexes*: This directory contains the indexes used by the Business API Ecosystem for searching
* */business-ecosystem-logic-proxy/themes*: This directory contains the themes that can be used to customize the web portal
* */business-ecosystem-logic-proxy/static*: This directory includes the static files ready to be rendered including the selected theme and js files

Finally, the biz-ecosystem-logic-proxy uses the environment variable *NODE_ENV* to determine if the software is being used
in *development* or in *production* mode. 

> **Note**
> The *config.js* file must include an extra setting not provided by default called *config.extPort* that must include the port where the proxy is going to run in the host machine

Once you have created the files, run the following command:

```
docker-compose up
```

Then, the Business API Ecosystem should be up and running in `http://YOUR_HOST:PORT/` replacing `YOUR_HOST` by the host of your machine and `PORT` by the port provided in the Business Ecosystem Logic Proxy configuration 

Once the different containers are running, you can stop them using:

```
docker-compose stop
```

And start them again using:

```
docker-compose start
```

Additionally, you can terminate the different containers by executing:

```
docker-compose down
```

### Stand alone Image

In addition, it has been provided a stand alone BAE image which already includes all the modules installed.

This image can be deployed with `docker-compose` using the following `docker-compose.yml` file:

```

version: "3"

services:
    mysql:
        image: mysql:latest
        ports:
            - "3333:3306"
        volumes:
            - ./mysql-data:/var/lib/mysql
        environment:
            - MYSQL_ROOT_PASSWORD=my-secret-pw

    mongo:
        image: mongo:3.2
        ports:
            - 27017:27017
        volumes:
            - ./mongo-data:/data/db

    biz_ecosystem:
        image: conwetlab/business-api-ecosystem:develop
        ports:
            - "8004:8000"
        links:
            - mysql
            - mongo
        volumes:
            # Configuration files
            - ./conf/rss:/etc/default/rss
            - ./conf/charging:/business-ecosystem-charging-backend/src/user_settings
            - ./conf/proxy:/business-ecosystem-logic-proxy/etc

            # Charging volumes
            - ./charging-bills:/business-ecosystem-charging-backend/src/media/bills
            - ./charging-assets:/business-ecosystem-charging-backend/src/media/assets
            - ./charging-plugins:/business-ecosystem-charging-backend/src/plugins
            - ./charging-inst-plugins:/business-ecosystem-charging-backend/src/wstore/asset_manager/resource_plugins/plugins

            # Proxy volumes
            - ./proxy-indexes:/business-ecosystem-logic-proxy/indexes
            - ./proxy-themes:/business-ecosystem-logic-proxy/themes
            - ./proxy-static:/business-ecosystem-logic-proxy/static

        environment:
            - MYSQL_ROOT_PASSWORD=my-secret-pw
            - MYSQL_HOST=mysql
            - PAYPAL_CLIENT_ID=your-paypal-client-id
            - PAYPAL_CLIENT_SECRET=your-paypal-client-secret
            - NODE_ENV=development

```

The next step is providing all the configuration files required by the BAE using the configured volumes.
It is possible to find valid configuration files (as well as the `docker-compose.yml`) in the [GitHub repo of the BAE](https://github.com/FIWARE-TMForum/Business-API-Ecosystem)

As you can see, the BAE image include some environment variables to be configured. In particular:
* **MYSQL_ROOT_PASSWORD**: Password of the root user of the configured MySQL instance
* **MYSQL_HOST**: Host of the configured MySQL instance
* **PAYPAL_CLIENT_ID**: the client id of your application PayPal credentials used for charging users (a Sandbox account can be used for testing).
* **PAYPAL_CLIENT_SECRET**: the client secret of your application PayPal credentials used for charging users (a Sandbox account can be used for testing).
* **NODE_ENV**: Determine if the software is being used in *development* or in *production* mode.

For providing configuration files 3 volumes are used:
* */etc/default/rss*: Thus directory must include the *database.properties* and *oauth.properties* files used for configuring the RSS
* */business-ecosystem-charging-backend/src/user_settings*: This directory must include the *settings.py* and *services_settings.py* files with the software configuration.
* */business-ecosystem-logic-proxy/etc*: This directory must include the `config.js` file with the software configuration

Additionally, for the assets managed by the charging backend 4 volumes are used. In particular:
* */business-ecosystem-charging-backend/src/media/bills*: This directory contains the PDF invoices generated by the Business Ecosystem Charging Backend
* */business-ecosystem-charging-backend/src/media/assets*: This directory contains the different digital assets uploaded by sellers to the Business Ecosystem Charging Backend
* */business-ecosystem-charging-backend/src/plugins*: This directory is used for providing asset plugins (see section *Installing Asset Plugins*)
* */business-ecosystem-charging-backend/src/wstore/asset_manager/resource_plugins/plugins*: This directory includes the code of the plugins already installed

Finally, for the management of logic proxy indexes and themes 3 volumes are provided:
* */business-ecosystem-logic-proxy/indexes*: This directory contains the indexes used by the Business API Ecosystem for searching
* */business-ecosystem-logic-proxy/themes*: This directory contains the themes that can be used to customize the web portal
* */business-ecosystem-logic-proxy/static*: This directory includes the static files ready to be rendered including the selected theme and js files

Once you have created the files, run the following command:

```
docker-compose up
```

Then, the Business API Ecosystem should be up and running in `http://YOUR_HOST:PORT/` replacing `YOUR_HOST` by the host of your machine and `PORT` by the port provided in the Business Ecosystem Logic Proxy configuration 

Once the different containers are running, you can stop them using:

```
docker-compose stop
```

And start them again using:

```
docker-compose start
```

Additionally, you can terminate the different containers by executing:

```
docker-compose down
```

## Version 5.4.1

New versions than 5.4.1 had changed the way configuration is provided. In this regard, the deployment of BAE images for
the version 5.4.1 is done in a different way to the explained in the previous section.

To the deploy the BAE image v5.4.1, you must create a folder to place a new file file called `docker-compose.yml` that should include the following content:

```

biz_db:
    image: mysql:latest
    ports:
        - "3333:3306"
    volumes:
        - /var/lib/mysql
    environment:
        - MYSQL_ROOT_PASSWORD=my-secret-pw

biz_ecosystem:
    image: fiware/business-api-ecosystem
    ports:
        - "8000:8000"
    links:
        - biz_db
    volumes:
        - /your/bills/path:/apis/business-ecosystem-charging-backend/src/media/bills
        - /your/assets/path:/apis/business-ecosystem-charging-backend/src/media/assets
        - /your/plugins/path:/apis/business-ecosystem-charging-backend/src/plugins
        - /your/indexes/path:/apis/business-ecosystem-logic-proxy/indexes
    environment:
        - MYSQL_ROOT_PASSWORD=my-secret-pw
        - MYSQL_HOST=biz_db
        - OAUTH2_CLIENT_ID=your-client-id
        - OAUTH2_CLIENT_SECRET=your-client-secret
        - PAYPAL_CLIENT_ID=your-paypal-client-id
        - PAYPAL_CLIENT_SECRET=your-paypal-client-secret
        - ADMIN_EMAIL=your@email.com
        - EMAIL_USER=your
        - EMAIL_PASSWD=your-passwd
        - EMAIL_SERVER=smtp.gmail.com
        - EMAIL_SERVER_PORT=587
        - BIZ_ECOSYS_PORT=your-port
        - BIZ_ECOSYS_HOST=your-host

```
Additionally, you can run the containers manually using the following commands:

```
sudo docker run --name biz_db -e MYSQL_ROOT_PASSWORD=my-secret-pw -p PORT:3306 -v /var/lib/mysql -d mysql
```

To Business API Ecosystem:

```
sudo docker run \
    -e MYSQL_ROOT_PASSWORD=my-secret-pw \
    -e MYSQL_HOST=rss_db \
    -e OAUTH2_CLIENT_ID=your-oauth-client-id \
    -e OAUTH2_CLIENT_SECRET=your-oauth-client-secret \
    -e BIZ_ECOSYS_PORT=your-port \
    -e BIZ_ECOSYS_HOST=your-host \
    -e PAYPAL_CLIENT_ID=your-paypal-client-id \
    -e PAYPAL_CLIENT_SECRET=your-paypal-client-secret \
    -e ADMIN_EMAIL=your@email.com \
    -p your-port:8000 --link biz_db fiware/business-api-ecosystem
```

Note in the previous commands, that it is needed to provide some environment variables. In particular:

* **MYSQL_ROOT_PASSWORD**: Password of the MySQL root user 
* **MYSQL_HOST**: Host of MySQL. If you are linking instances this value will be the name of the MySQL container
* **OAUTH2_CLIENT_ID**: Client id given by the FIWARE IdM for the application
* **OAUTH2_CLIENT_SECRET**: Client secret given by the FIWARE IdM for the application
* **PAYPAL_CLIENT_ID**: Client id given by PayPal for the application in order to charge customers (Sanbox accounts are allowed)
* **PAYPAL_CLIENT_SECRET**: Client secret given by PayPal for the application in order to charge customers (Sanbox accounts are allowed)
* **ADMIN_EMAIL**: Valid email required for administration
* **BIZ_ECOSYS_PORT**: Port where the Business API Ecosystem is going to run
* **BIZ_ECOSYS_HOST**: Host where the Business API Ecosystem is going to run

Additionally, it is possible to provide some optional variables that enable the software sending
email notifications:

* **EMAIL_USER**: User of the email account to be used for notifications
* **EMAIL_PASSWD**: Password of the email account to be used for notifications
* **EMAIL_SERVER**: SMTP server host of the email account to be used for notifications
* **EMAIL_SERVER_PORT**: SMTP server port of the email account to be used for notifications

Moreover, the Business API Ecosystem image defines 4 containers intended to persist and share 
some information. Specifically, the following volumes have been defined:

* **/apis/business-ecosystem-charging-backend/src/media/bills**: This volume is used for saving the generated PDF invoices
* **/apis/business-ecosystem-charging-backend/src/media/assets**: This volume is used for saving the uploaded digital assets
* **/apis/business-ecosystem-charging-backend/src/plugins**: This volume is intended for supporting the installation of digital assets plugins (see *Installing Asset Plugins* section)
* **/apis/business-ecosystem-logic-proxy/indexes**: This volume is used for saving the indexes used for searching and paginating


## Installing Asset Plugins

As you may know, the Business API Ecosystem is able to sell different types of digital assets
by loading asset plugins in its Charging Backend. In this context, it is possible to install
asset plugins in the current Docker image as follows:

1) Copy the plugin file into the host directory of the volume */business-ecosystem-charging-backend/src/plugins*

2) Enter the running container:
```
docker exec -i -t your-container /bin/bash
```

3) Go to the installation directory
```
cd /apis/business-ecosystem-charging-backend/src
```

4) Load the plugin
```
./manage.py loadplugin ./plugins/pluginfile.zip
```

5) Restart Apache
```
service apache2 restart
```