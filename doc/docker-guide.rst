=======================
Docker Deployment Guide
=======================

This guide covers the deployment of the Business API Ecosystem version 7.8.0 using the Docker images provided in docker hub.

As stated, the Business API Ecosystem in made up of a set of different components which work jointly in order to provide
the functionality. In this regard the following images has been defined:

* fiware/biz-ecosystem-apis: This image includes all the TMForum APIs and can be found in `Docker Hub <https://hub.docker.com/r/fiware/biz-ecosystem-apis/>`__
* fiware/biz-ecosystem-charging-backend: This image includes the Charging Backend component and can be found in `Docker Hub <https://hub.docker.com/r/fiware/biz-ecosystem-charging-backend/>`__
* fiware/biz-ecosystem-logic-proxy: This image includes the Logic Proxy component and can be found in `Docker Hub <https://hub.docker.com/r/fiware/biz-ecosystem-logic-proxy/>`__
* fiware/biz-ecosystem-rss: This Image include the Revenue Sharing Component and can be found in `Docker Hub <https://hub.docker.com/r/fiware/biz-ecosystem-rss/>`__

The easiest way to deploy the Business API Ecosystem with Docker is using *docker-compose*. The following *docker-compose.yml*
file deploys the whole system and databases (A running version of this file can be found in GitHub): ::

    version: '3'
    services:
        elasticsearch:
            image: docker.elastic.co/elasticsearch/elasticsearch:7.9.1
            environment:
                - discovery.type=single-node
            ports:
                - "127.0.0.1:9200:9200"
            networks:
                main:

        mongo:
            image: mongo:3.2
            restart: always
            networks:
                main:
            volumes:
                - ./mongo-data:/data/db

        mysql:
            image: mysql:5.7
            restart: always
            volumes:
                - ./mysql-data:/var/lib/mysql
            networks:
                main:
            environment:
                - MYSQL_ROOT_PASSWORD=my-secret-pw
                - MYSQL_DATABASE=RSS

        charging:
            image: fiware/biz-ecosystem-charging-backend:v7.8.0
            links:
                - mongo
            depends_on:
                - mongo
            networks:
                main:
                    aliases:
                        - charging.docker
            ports:
                - 8006:8006
            volumes:
                - ./charging-bills:/business-ecosystem-charging-backend/src/media/bills
                - ./charging-assets:/business-ecosystem-charging-backend/src/media/assets
                - ./charging-plugins:/business-ecosystem-charging-backend/src/plugins
                - ./charging-inst-plugins:/business-ecosystem-charging-backend/src/wstore/asset_manager/resource_plugins/plugins
            environment:
            - BAE_CB_PAYMENT_METHOD=None  # paypal or None (testing mode payment disconected)
              # - BAE_CB_PAYPAL_CLIENT_ID=client_id
              # - BAE_CB_PAYPAL_CLIENT_SECRET=client_secret

              # ----- Database configuration ------
            - BAE_CB_MONGO_SERVER=mongo
            - BAE_CB_MONGO_PORT=27017
            - BAE_CB_MONGO_DB=charging_db
              # - BAE_CB_MONGO_USER=user
              # - BAE_CB_MONGO_PASS=passwd

              # ----- Roles Configuration -----
            - BAE_LP_OAUTH2_ADMIN_ROLE=admin
            - BAE_LP_OAUTH2_SELLER_ROLE=seller
            - BAE_LP_OAUTH2_CUSTOMER_ROLE=customer

              # ----- Email configuration ------
            - BAE_CB_EMAIL=charging@email.com
              # - BAE_CB_EMAIL_USER=user
              # - BAE_CB_EMAIL_PASS=pass
              # - BAE_CB_EMAIL_SMTP_SERVER=smtp.server.com
              # - BAE_CB_EMAIL_SMTP_PORT=587

            - BAE_CB_VERIFY_REQUESTS=True  # Whether or not the BAE validates SSL certificates on requests to external components 

              # ----- Site configuration -----
            - BAE_SERVICE_HOST=http://proxy.docker:8004/  # External URL used to access the BAE
            - BAE_CB_LOCAL_SITE=http://charging.docker:8006/  # Local URL of the charging backend

              # ----- APIs Conection config -----
            - BAE_CB_CATALOG=http://apis.docker:8080/DSProductCatalog
            - BAE_CB_INVENTORY=http://apis.docker:8080/DSProductInventory
            - BAE_CB_ORDERING=http://apis.docker:8080/DSProductOrdering
            - BAE_CB_BILLING=http://apis.docker:8080/DSBillingManagement
            - BAE_CB_RSS=http://rss.docker:8080/DSRevenueSharing
            - BAE_CB_USAGE=http://apis.docker:8080/DSUsageManagement
            - BAE_CB_AUTHORIZE_SERVICE=http://proxy.docker:8004/authorizeService/apiKeys

        proxy:
            image: fiware/biz-ecosystem-logic-proxy:v7.8.0
            links:
                - mongo
                - elasticsearch
            depends_on:
                - mongo
                - elasticsearch
            networks:
                main:
                    aliases:
                        - proxy.docker
            ports:
                - 8004:8004
            volumes:
                - ./proxy-themes:/business-ecosystem-logic-proxy/themes
                - ./proxy-static:/business-ecosystem-logic-proxy/static
                - ./proxy-locales:/business-ecosystem-logic-proxy/locales
            environment:
                - NODE_ENV=development  # Deployment in development or in production
                - COLLECT=True  # Execute the collect static command on startup

                - BAE_LP_PORT=8004  # Port where the node service is going to run in the container
                - BAE_LP_HOST=proxy.docker  # Host where the node service if going to run in the container
                # - BAE_SERVICE_HOST=https://store.lab.fiware.org/  # If provided, this URL specifies the actual URL that is used to access the BAE, when the component is proxied (e.g Apache)
                # - BAE_LP_HTTPS_ENABLED=true  # If provided specifies whether the service is running in HTTPS, default: false
                # - BAE_LP_HTTPS_CERT=cert/cert.crt  # Certificate for the SSL configuration (when HTTPS enabled is true)
                # - BAE_LP_HTTPS_CA=cert/ca.crt  # CA certificate for the SSL configuration (when HTTPS enabled is true)
                # - BAE_LP_HTTPS_KEY=cert/key.key  # Key sfile for the SSL configuration (when HTTPS enabled is true)
                # - BAE_LP_HTTPS_PORT=443  # Port where the service runs when SSL is enabled (when HTTPS enabled is true)

                # ------ OAUTH2 Config ------
                - BAE_LP_OAUTH2_SERVER=http://idm.docker:3000  # URL of the FIWARE IDM used for user authentication
                - BAE_LP_OAUTH2_CLIENT_ID=f0ab257d-7456-41e8-bb0a-002148ac0217  # OAuth2 Client ID of the BAE applicaiton
                - BAE_LP_OAUTH2_CLIENT_SECRET=d5ea8cce-08ea-4cb2-8379-66bb35020cee  # OAuth Client Secret of the BAE application
                - BAE_LP_OAUTH2_CALLBACK=http://proxy.docker:8004/auth/fiware/callback  # Callback URL for receiving the access tokens
                - BAE_LP_OAUTH2_ADMIN_ROLE=admin  # Role defined in the IDM client app for admins of the BAE 
                - BAE_LP_OAUTH2_SELLER_ROLE=seller  # Role defined in the IDM client app for sellers of the BAE 
                - BAE_LP_OAUTH2_CUSTOMER_ROLE=customer  # Role defined in the IDM client app for customers of the BAE 
                - BAE_LP_OAUTH2_ORG_ADMIN_ROLE=orgAdmin  # Role defined in the IDM client app for organization admins of the BAE 
                - BAE_LP_OAUTH2_IS_LEGACY=false  # Whether the used FIWARE IDM is version 6 or lower

                # - BAE_LP_THEME=theme  # If provided custom theme to be used by the web site, it must be included in themes volume

                # ----- Mongo Config ------
                # - BAE_LP_MONGO_USER=user
                # - BAE_LP_MONGO_PASS=pass
                - BAE_LP_MONGO_SERVER=mongo
                - BAE_LP_MONGO_PORT=27017
                - BAE_LP_MONGO_DB=belp

                - BAE_LP_REVENUE_MODEL=30  # Default market owner precentage for Revenue Sharing models
                - BAE_LP_TAX_RATE=20  # Tax rate applied to offers in the marketplace

                # ----- Indexing engine  -------
                - BAE_LP_INDEX_ENGINE=elasticsearch   # Indexig engine: elasticsearch or local
                - BAE_LP_INDEX_URL=elasticsearch:9200  # URL of elasticsearch
                - BAE_LP_INDEX_API_VERSION=7  # API version of elasticsearch

                # ----- APIs Configuration -----
                # If provided, it supports configuring the contection to the different APIs managed by the logic proxy, by default
                # apis.docker, charging.docker and rss.docker domains are configured
                # - BAE_LP_ENDPOINT_CATALOG_PATH=DSProductCatalog
                # - BAE_LP_ENDPOINT_CATALOG_PORT=8080
                # - BAE_LP_ENDPOINT_CATALOG_HOST=apis.docker
                # - BAE_LP_ENDPOINT_CATALOG_SECURED=false
                # ...

        apis:
            image: fiware/biz-ecosystem-apis:v7.6.0
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
            # volumes:
            #    - ./apis-conf:/etc/default/tmf/  # Used if not configured by environment
            environment:
                - BAE_SERVICE_HOST=http://proxy.docker:8004/
                - MYSQL_ROOT_PASSWORD=my-secret-pw
                - MYSQL_HOST=mysql

        rss:
            image: fiware/biz-ecosystem-rss:v7.8.0
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
            # volumes:
            #    - ./rss-conf:/etc/default/rss  # Used if not configured by environment
            environment:
                - BAE_RSS_DATABASE_URL=jdbc:mysql://mysql:3306/RSS
                - BAE_RSS_DATABASE_USERNAME=root
                - BAE_RSS_DATABASE_PASSWORD=my-secret-pw
                - BAE_RSS_DATABASE_DRIVERCLASSNAME=com.mysql.jdbc.Driver
                - BAE_RSS_OAUTH_CONFIG_GRANTEDROLE=admin
                - BAE_RSS_OAUTH_CONFIG_SELLERROLE=seller
                - BAE_RSS_OAUTH_CONFIG_AGGREGATORROLE=Aggregator

    networks:
        main:
            external: true


.. note::
    The previous example uses an external network called *main*, which need to exist. If you do not want to use such network just remove the network tags


It can be seen that the different images can be configured using different environment variables.
For details on the different configuration options, please refer to the `*Configuration Guide* <doc:configuration-guide>`__

It can be seen that the different images used as part of the Business API Ecosystem provide several volumes. Following 
it is described the diffent options provided by each image.

The **biz-ecosystem-logic-proxy** image defines 4 volumes. In particular:

* */business-ecosystem-logic-proxy/indexes*: This volume contains the indexes used by the Business API Ecosystem for searching
* */business-ecosystem-logic-proxy/themes*: In this volume, it can be provided the themes that can be used to customize the web portal
* */business-ecosystem-logic-proxy/static*: This volume includes the static files ready to be rendered including the selected theme and js files

Additionally, the **biz-ecosystem-logic-proxy** image defines two environment variables intended to optimize the production deployment of the BAE Logic proxy:

* *NODE_ENV*: Specifies whether the system is in *development* or in *production* (default: development)
* *COLLECT*: Specifies if the container should execute the collect static command to generate static files or use the existing on start up (default: True)

On the other hand, the **biz-ecosystem-charging-backend** image defines 4 volumes. In particular:

* */business-ecosystem-charging-backend/src/media/bills*: This directory contains the PDF invoices generated by the Business Ecosystem Charging Backend
* */business-ecosystem-charging-backend/src/media/assets*: This directory contains the different digital assets uploaded by sellers to the Business Ecosystem Charging Backend
* */business-ecosystem-charging-backend/src/plugins*: This directory is used for providing asset plugins (see section *Installing Asset Plugins*)
* */business-ecosystem-charging-backend/src/wstore/asset_manager/resource_plugins/plugins*: This directory includes the code of the plugins already installed

------------------------
Installing Asset Plugins
------------------------

As you may know, the Business API Ecosystem is able to sell different types of digital assets
by loading asset plugins in its Charging Backend. In this context, it is possible to install
asset plugins in the current Docker image as follows:

1) Copy the plugin file into the host directory of the volume */business-ecosystem-charging-backend/src/plugins*

2) Enter the running container: ::

    docker exec -i -t your-container bash


3) Go to the installation directory ::

    cd /business-ecosystem-charging-backend/src


4) Load the plugin ::

    ./manage.py loadplugin ./plugins/pluginfile.zip


5) Restart Apache ::

    service apache2 graceful

