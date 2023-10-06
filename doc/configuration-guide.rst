===================
Configuration Guide
===================

This guide covers the different configuration options that are available in order to setup a working Business API
Ecosystem instance. The different Business API Ecosystem components can be configured using two different mecahnisms,
settings files and environment variables.

At this step, the different components of the Business API Ecosystem are installed. In the case of the TMForum APIs and
the RSS, this installation process has already required to configure their database connection before their deployment,
so they are already configured. Nevertheless, this section contains an explanation of the function of the different
settings of the RSS properties files.

--------------------------------
Configuring the Charging Backend
--------------------------------

The Charging Backend creates some objects and connections in the different APIs while working, so the first step is
configuring the different URLs of the Business API Ecosystem components by modifying the file *services_settings.py*,
which by default contains the following content: ::

    SITE = 'http://localhost:8004/'
    LOCAL_SITE = 'http://localhost:8006/'

    CATALOG = 'http://localhost:8080/DSProductCatalog'
    INVENTORY = 'http://localhost:8080/DSProductInventory'
    ORDERING = 'http://localhost:8080/DSProductOrdering'
    BILLING = 'http://localhost:8080/DSBillingManagement'
    RSS = 'http://localhost:8080/DSRevenueSharing'
    USAGE = 'http://localhost:8080/DSUsageManagement'
    AUTHORIZE_SERVICE = 'http://localhost:8004/authorizeService/apiKeys'

These settings point to the different APIs accessed by the charging backend. In particular:

* SITE: External URL of the complete Business API Ecosystem using for Href creation
* LOCAL_SITE: URL where the Charging Backend is going to run
* CATALOG: URL of the catalog API including its path
* INVENTORY: URL of the inventory API including its path
* ORDERING: URL of the ordering API including its path
* BILLING: URL of the billing API including its path
* RSS: URL of the RSS including its path
* USAGE: URL of the Usage API including its path
* AUTHORIZE_SERVICE: Complete URL of the usage authorization service. This service is provided by the logic proxy, and is used to generate API Keys to be used by accounting systems when providing usage information.

These settings can be configured using the following environment variables: ::

    BAE_SERVICE_HOST=http://proxy.docker:8004/
    BAE_CB_LOCAL_SITE=http://charging.docker:8006/
    BAE_CB_CATALOG=http://apis.docker:8080/DSProductCatalog
    BAE_CB_INVENTORY=http://apis.docker:8080/DSProductInventory
    BAE_CB_ORDERING=http://apis.docker:8080/DSProductOrdering
    BAE_CB_BILLING=http://apis.docker:8080/DSBillingManagement
    BAE_CB_RSS=http://rss.docker:8080/DSRevenueSharing
    BAE_CB_USAGE=http://apis.docker:8080/DSUsageManagement
    BAE_CB_AUTHORIZE_SERVICE=http://proxy.docker:8004/authorizeService/apiKeys


Once the services have been configured, the next step is configuring the database. In this case, the charging backend uses
MongoDB, and its connection can be configured modifying the *DATABASES* setting of the *settings.py* file. ::

    DATABASES = {
        "default": {
            "ENGINE": "djongo",
            "NAME": "wstore_db",
            "ENFORCE_SCHEMA": False,
            "CLIENT": {
                "host": "localhost",
                "port": 27017
                "username': "mongoadmin",
                "password': "mongopass"
            },
        }
    }

This setting contains the following fields:

* ENGINE: Database engine, must be fixed to djongo
* NAME: Name of the database to be used
* CLIENT: Configuration for connecting to MongoDB
    * host: Host of the database. If empty it uses the default *localhost* host
    * port: Port of the database. If empty it uses the default *27017* port
    * username: User of the database. If empty the software creates a non authenticated connection
    * password: Database user password. If empty the software creates a non authenticated connection

These settings can be configured using the environment with the following variables: ::

    BAE_CB_MONGO_SERVER=mongo
    BAE_CB_MONGO_PORT=27017
    BAE_CB_MONGO_DB=charging_db
    BAE_CB_MONGO_USER=user
    BAE_CB_MONGO_PASS=passwd

Once the database connection has been configured, the next step is configuring the name of the IdM roles to be used by
updating *settings.py* ::

    ADMIN_ROLE = 'provider'
    PROVIDER_ROLE = 'seller'
    CUSTOMER_ROLE = 'customer'

This settings contain the following values:

* ADMIN_ROLE: IDM role of the system admin
* PROVIDER_ROLE: IDM role of the users with seller privileges
* CUSTOMER_ROLE: IDM role of the users with customer privileges

These parameters can be configured with the environment using: ::

    BAE_LP_OAUTH2_ADMIN_ROLE=admin
    BAE_LP_OAUTH2_SELLER_ROLE=seller
    BAE_LP_OAUTH2_CUSTOMER_ROLE=customer

The charging backend is the component in charge of maintaining the supported currencies and the timeframe of the different
periods using in recurring pricing models. To configure both, the following settings are used: ::

    CURRENCY_CODES = [
        ('EUR', 'Euro'),
        ('AUD', 'Australia Dollar'),
        ...
    ]
    CHARGE_PERIODS = {
        'daily': 1,  # One day
        'weekly': 7,  # One week
        'monthly': 30,  # One month
        ...
    }

* CURRENCY_CODES: Includes the list of currencies supported by the system as a tuple of currency code and currency name.
* CHARGE_PERIODS: Includes the list of supported periods for recurring models, specifing the time (in days) between periodic charges

The Charging Backend component is able to send email notifications to the users when they are charged or receive a payment.
In this way, it is possible to provide email configuration in the *settings.py* file by modifying the following fields: ::

    WSTOREMAILUSER = 'email_user'
    WSTOREMAIL = 'wstore_email'
    WSTOREMAILPASS = 'wstore_email_passwd'
    SMTPSERVER = 'wstore_smtp_server'
    SMTPPORT = 587

This settings contain the following values:
* WSTOREMAILUSER: Username used for authenticating in the email server
* WSTOREMAIL: Email to be used as the sender of the notifications
* WSTOREMAILPASS: Password of the user for authenticating in the email server
* SMTPSERVER: Email server host
* SMTPPORT: Email server port

These settings can be configured with the environment using: ::

    BAE_CB_EMAIL=charging@email.com
    BAE_CB_EMAIL_USER=user
    BAE_CB_EMAIL_PASS=pass
    BAE_CB_EMAIL_SMTP_SERVER=smtp.server.com
    BAE_CB_EMAIL_SMTP_PORT=587

.. note::
    The email configuration in optional. However, the field WSTOREMAIL must be provided since it is used internally for RSS configuration

Additionally, the Charging Backend is the component that charges customers and pays providers. For this purpose it uses
PayPal. For configuring paypal, the first step is setting *PAYMENT_METHOD* to *paypal* in the *settings.py* file ::

    PAYMENT_METHOD = 'paypal'

Then, it is required to provide PayPal application credentials by updating the file *src/wstore/charging_engine/payment_client/paypal_client.py* ::

    PAYPAL_CLIENT_ID = ''
    PAYPAL_CLIENT_SECRET = ''
    MODE = 'sandbox'  # sandbox or live

These settings contain the following values:

* PAYPAL_CLIENT_ID: Id of the application provided by PayPal
* PAYPAL_CLIENT_SECRET: Secret of the application provided by PayPal
* MODE: Mode of the connection. It can be *sandbox* if using the PayPal sandbox for testing the system. Or *live* if using the real PayPal APIs

In addition, these settings can be configured using the following environment variables: ::

    BAE_CB_PAYMENT_METHOD=paypal
    BAE_CB_PAYPAL_CLIENT_ID=client_id
    BAE_CB_PAYPAL_CLIENT_SECRET=client_secret

The charging backend component can be configured to expect or not the user access token to be propagated
from the business logic proxy component, depending on the use case and the expected plugins to be installed.
This can be configured with the following setting: ::

    PROPAGATE_TOKEN = True

This setting can be also configured using the environment as follows: ::

    export BAE_CB_PROPAGATE_TOKEN=true

Moreover, the Charging Backend is the component that activates the purchased services. In this regard, the Charging Backend
has the possibility of signing its acquisition notifications with a certificate, so the external system being offered can
validate that is the Charging Backend the one making the request. To use this functionality it is needed to configure the
certificate and the private Key to be used by providing its path in the following settings of the *settings.py* file ::

    NOTIF_CERT_FILE = None
    NOTIF_CERT_KEY_FILE = None

The Charging Backend uses a Cron task to check the status of recurring and usage subscriptions, and for paying sellers.
The periodicity of this tasks can be configured using the CRONJOBS setting of settings.py using the standard Cron format ::

    CRONJOBS = [
        ('0 5 * * *', 'django.core.management.call_command', ['pending_charges_daemon']),
        ('0 6 * * *', 'django.core.management.call_command', ['resend_cdrs']),
        ('0 4 * * *', 'django.core.management.call_command', ['resend_upgrade']
    ]

Once the Cron task has been configured, it is necessary to include it in the Cron tasks using the command:
::

    $ python3 manage.py crontab add

It is also possible to show current jobs or remove jobs using the commands:
::

    $ python3 manage.py crontab show

    $ python3 manage.py crontab remove

---------------------------
Configuring the Logic Proxy
---------------------------

Configuration of the Logic Proxy is located at *config.js* and can be provided in two different ways: providing the values
in the file or using the defined environment variables. Note that the environment variables override the values in *config.js*.

The first setting to be configured is the port and host where the proxy is going to run, these settings are located in *config.js* ::

    config.port = 80;
    config.host = 'localhost';

In addition, the environment variables *BAE_LP_PORT* and *BAE_LP_HOST* can be used to override those values. ::

    export BAE_LP_PORT=80
    export BAE_LP_HOST=localhost

If you want to run the proxy in HTTPS you can update *config.https* setting ::

    config.https = {
        enabled: false,
        certFile: 'cert/cert.crt',
        keyFile: 'cert/key.key',
        caFile: 'cert/ca.crt',
        port: 443
    };

In this case you have to set *enabled* to true, and provide the paths to the certificate (*certFile*), to the private key (*keyFile*),
and to the CA certificate (*caFile*).

In order to provide the HTTPS configuration using the environment, the following variables has been defined. ::

    export BAE_LP_HTTPS_ENABLED=true
    export BAE_LP_HTTPS_CERT=cert/cert.crt
    export BAE_LP_HTTPS_CA=cert/key.key
    export BAE_LP_HTTPS_KEY=cert/ca.crt
    export BAE_LP_HTTPS_PORT=443

The logic proxy supports the BAE to be deployed behind a proxy (or NGINX, Apache, etc) not sending X-Forwarding headers. In this
regard, the following setting is used in order to provide information about the actual endpoint which is used to access to the
Business API Ecosystem: ::

    config.proxy = {
        enabled: true,
        host: 'store.lab.fiware.org',
        secured: true,
        port: 443
    };

Which can be also configured using the *BAE_SERVICE_HOST* environment variable. ::

    export BAE_SERVICE_HOST=https://store.lab.fiware.org/

Then, it is possible to modify some of the URLs of the system. In particular, it is possible to provide a prefix for the API,
a prefix for the portal, and modifying the login and logout URLS ::

    config.proxyPrefix = '';
    config.portalPrefix = '';
    config.logInPath = '/login';
    config.logOutPath = '/logOut';

In addition, it is possible to configure the theme to be used by providing its name. Details about the configuration of
Themes are provided in the *Configuring Themes* section::

    config.theme = '';

The theme can be configured using the *BAE_LP_THEME* variable. ::

    export BAE_LP_THEME=fiwaretheme

The BAE supports multiple external IDPs to be configured in order to allow organizations
to login using their own IDP, when registered in a trust provider like iShare. To enable such feature the following setting
needs to be configured: ::

    config.extLogin = true;

This setting can be also configured using the environment as follows: ::

    export BAE_LP_EXT_LOGIN=true

In addition, it is possible to configure whether the proxy component should propagate user access token
to the backend components (charging backend, RSS and APIs), depending on the use case and the plugins
installed. To configure such setting, the following is used: ::

    config.propagateToken = true;

That can be configured using the environment as follows: ::

    export BAE_LP_PROPAGATE_TOKEN=true

Moreover, the Proxy uses MongoDB for maintaining some info, such as the current shopping cart of a user. you can configure
the connection to MongoDB by updating the following setting: ::

    config.mongoDb = {
        server: 'localhost',
        port: 27017,
        user: '',
        password: '',
        db: 'belp'
    };

In this setting you can configure the host (*server*), the port (*port*), the database user (*user*), the database user password
(*password*), and the database name (*db*).

In addition, the database connection can be configured with the environment as following: ::

    export BAE_LP_MONGO_USER=user
    export BAE_LP_MONGO_PASS=pass
    export BAE_LP_MONGO_SERVER=localhost
    export BAE_LP_MONGO_PORT=27017
    export BAE_LP_MONGO_DB=belp

As already stated, the Proxy is the component that acts as the endpoint for accessing the different APIs. In this way,
the proxy needs to know the URLs of them in order to redirect the different requests. This endpoints can be configured using the
following settings ::

    config.endpoints = {
        'catalog': {
            'path': 'DSProductCatalog',
            'host': 'localhost'
            'port': '8080',
            'appSsl': false
        },
        'ordering': {
            'path': 'DSProductOrdering',
            'host': 'localhost'
            'port': '8080',
            'appSsl': false
        },

        ...

The setting *config.endpoints* contains the specific configuration of each of the APIs, including its *path*, its *host*,
its *port*, and whether the API is using SSL or not.

.. note::
    The default configuration included in the config file is the one used by the installation script, so if you have used the script for
    installing the Business API Ecosystem you do not need to modify these fields

Each of the different APIs can be configured with environment variables with the following pattern: ::

    export BAE_LP_ENDPOINT_CATALOG_PATH=DSProductCatalog
    export BAE_LP_ENDPOINT_CATALOG_PORT=8080
    export BAE_LP_ENDPOINT_CATALOG_HOST=localhost
    export BAE_LP_ENDPOINT_CATALOG_SECURED=false

The Business API Ecosystem uses an indexes system managed by the Logic Proxy in order to perform queries,
searches, and paging the results. Starting in version 7.6.0 it is possible to use elasticsearch for the
indexing rather than using the local file system. The indexing system is configured with the following settings. ::

    config.indexes = {
        'engine': 'elasticsearch', // local or elasticsearch
        'elasticHost': 'elastic.docker:9200'
        'apiVersion': '7.5'
    };

The *engine* setting can be used to chose between *local* indexes and *elasticsearch* indexes.
If the later is chosen the URL of elasticsearch is provided with *elasticHost*. 

These settings can be configured using the environment as follows: ::

    export BAE_LP_INDEX_ENGINE=elasticsearch
    export BAE_LP_INDEX_URL=elasticsearch:9200
    export BAE_LP_INDEX_API_VERSION=7

Finally, there are two fields that allow to configure the behaviour of the system while running. On the one hand, *config.revenueModel*
allows to configure the default percentage that the Business API Ecosystem is going to retrieve in all the transactions.
On the other hand, *config.usageChartURL* allows to configure the URL of the chart to be used to display product usage to
customers in the web portal. They can be configured with environment variables with *BAE_LP_REVENUE_MODEL* and *BAE_LP_USAGE_CHART*

Identity Management
===================

Additionally, the proxy is the component that acts as the front end of the Business API Ecosystem, both providing a web portal,
and providing the endpoint for accessing to the different APIs. In this regard, the Proxy includes the IDP and login configuration.
The BAE supports multiple IPD implementations. In particular:

* FIWARE Keyrock
* Keycloak
* GitHub
* FIWARE Keyrock + iShare protocol
* OIDC with discovery server

To configure the IPD integration thw setting *oauth2* is used. The following example shows an example configuration using Keyrock ::

    config.oauth2 = {
        'provider': 'fiware',
        'server': 'https://account.lab.fiware.org',
        'clientID': '<client_id>',
        'clientSecret': '<client_secret>',
        'callbackURL': 'http://<proxy_host>:<proxy_port>/auth/fiware/callback',
        'roles': {
            'admin': 'admin',
            'customer': 'customer',
            'seller': 'seller',
            'orgAdmin': 'orgAdmin'
        }
    };


In this settings, the value of *provider* is used to configure the IDP type. Then,
it is needed to include the IDM instance being used (*server*), the client id given by the IdM (*clientID*),
the client secret given by the IdM (*clientSecret*), and the callback URL configured in the IdM (*callbackURL*).

In addition, the different roles allow to specify what users are admins of the system (*Admin*), what users can create products
and offerings (*Seller*), and what users are admins of a particular organization, enabling to manage its information (*orgAdmin*).
Note that while *admin* and *seller* roles are granted directly to the users in the Business API Ecosystem application, the *orgAdmin*
role has to be granted to users within IdM organizations.

.. note::
    Admin, Seller, and orgAdmin roles are configured in the Proxy settings, so any name can be chosen for them in the IDM

The OAuth2 settings can be configured using the environment as follows: ::

    export BAE_LP_OAUTH2_PROVIDER=fiware
    export BAE_LP_OAUTH2_SERVER=https://account.lab.fiware.org
    export BAE_LP_OAUTH2_CLIENT_ID=client_id
    export BAE_LP_OAUTH2_CLIENT_SECRET=client_secret
    export BAE_LP_OAUTH2_CALLBACK=http://<proxy_host>:<proxy_port>/auth/fiware/callback
    export BAE_LP_OAUTH2_ADMIN_ROLE=admin
    export BAE_LP_OAUTH2_SELLER_ROLE=seller
    export BAE_LP_OAUTH2_ORG_ADMIN_ROLE=orgAdmin


For Keycloak provider some extra settings need to be provided. The following is an example of a Keycloak configuration: ::

    config.oauth2 = {
        provider: 'keycloak',
        server: 'http://keycloak.docker:8080',
        clientID: 'bae',
        clientSecret: 'df68d1b9-f85f-4b5e-807c-c8be3ba27388',
        callbackURL: 'http://proxy.docker:8004/auth/keycloak/callback',
        realm: 'bae',
        roles: {
            admin: 'admin',
            customer: 'customer',
            seller: 'seller',
            orgAdmin: 'manager'
        }
    }

It can be seen that the *provider* setting is set to keycloak and that the *realm* setting is used to specify the Keycloak realm.
Such setting can be configured using the environment using: ::

    export BAE_LP_OIDC_REALM=bae

When using the iShare protocol, the configuration requires the certificate issues by iShare to be provided in order to generate
and sign the JWT used in such a protocol. Such info can be provided by the settings *tokenCrt* and *tokenKey* or via enviroment with: ::

    export BAE_LP_OIDC_TOKEN_KEY=...
    export BAE_LP_OIDC_TOKEN_CRT=...

Finally, if the OIDC protocol is used the following settings need to be configured:

* oidcScopes: Scopes requested in the OIDC request
* oidcDiscoveryURI: Discovery endpoint for the OIDC protocol
* oidcTokenEndpointAuthMethod: Method used for retriving the access token in the OIDC server

Such settings can be configured with the environ using: ::

    BAE_LP_OIDC_SCOPES
    BAE_LP_OIDC_DISCOVERY_URI
    BAE_LP_OIDC_TOKEN_AUTH_METHOD

------------------------
Configuring the TMF APIs
------------------------

When the TMF APIs are deployed from sources, the connection to the MySQL database is configured during the installation process
setting up the jdbc connection as described in the *Installation and Administration* guide.

On the other hand, the Docker image biz-ecosystem-apis, which is used to the deploy TMF APIs using Docker, uses two environment
variables for configuring such connection. ::

    MYSQL_ROOT_PASSWORD=my-secret-pw
    MYSQL_HOST=mysql

Finally, the TMF APIs can optionally use a configuration file called *settings.properties* which is located by default at */etc/default/apis*.
This file include a setting *server* which allows to provide the URL used to access to the Business API Ecosystem and, in particular, by the APIs
in order to generate *hrefs* with the proper reference. ::

    server=https://store.lab.fiware.org/

This setting can also be configured using the environment variable *BAE_SERVICE_HOST* ::

    export BAE_SERVICE_HOST=https://store.lab.fiware.org/


-------------------
Configuring the RSS
-------------------

The RSS has its settings included in two files located at */etc/default/rss*. The file *database.properties*  contains
by default the following fields: ::

    database.url=jdbc:mysql://localhost:3306/RSS
    database.username=root
    database.password=root
    database.driverClassName=com.mysql.jdbc.Driver

This file contains the configuration required in order to connect to the database.

* database.url: URL used to connect to the database, this URL includes the host and port of the database as well as the concrete database to be used
* database.username: User to be used to connect to the database
* database.password: Password of the database user
* database.driverClassName: Driver class of the database. By default MySQL

In addition, database settings can be configured using the environment. In particular, using the following variables: ::

    export BAE_RSS_DATABASE_URL=jdbc:mysql://mysql:3306/RSS
    export BAE_RSS_DATABASE_USERNAME=root
    export BAE_RSS_DATABASE_PASSWORD=my-secret-pw
    export BAE_RSS_DATABASE_DRIVERCLASSNAME=com.mysql.jdbc.Driver

The file *oauth.properties* contains by default the following fields (It is recommended not to modify them) ::

    config.grantedRole=admin
    config.sellerRole=Seller
    config.aggregatorRole=aggregator

This file contains the name of the roles (registered in the idm) that are going to be used by the RSS.

* config.grantedRole: Role in the IDM of the users with admin privileges
* config.sellerRole: Role in the IDM of the users with seller privileges
* config.aggregatorRole: Role of the users who are admins of an store instance. In the context of the Business API Ecosystem there is only a single store instance, so you can safely ignore this flag

Those settings can also be configured using the environment as ::

    export BAE_RSS_OAUTH_CONFIG_GRANTEDROLE=admin
    export BAE_RSS_OAUTH_CONFIG_SELLERROLE=Seller
    export BAE_RSS_OAUTH_CONFIG_AGGREGATORROLE=Aggregator

------------------
Configuring Themes
------------------

The Business API Ecosystem provides a basic mechanism for the creation of themes intended to customize the web portal
of the system. Themes include a set of files which can override any of the default portal files located in the *public/resources*
or *views* directories of the logic proxy. To do that, themes map the directory structure and include files with the same
name of the default ones to be overridden.

The Logic Proxy can include multiple themes which should be stored in the *themes* directory located at the root of the
project.

To enable themes, the *config.theme* setting is provided within the *config.js* file of the Logic Proxy. Themes are
enabled by providing the name of the theme directory in this setting. ::

    config.theme = 'dark-theme';

.. note::
    Setting *config.theme* to an empty string makes the Business API Ecosystem to use its default theme

To start using a theme the following command has to be executed: ::

    $ node collect_static.js

This command merges the theme files and the default ones into a *static* directory used by the Logic Proxy to retrieve
portal static files.

-------------------
Enabling Production
-------------------

The default installation of the Business API Ecosystem deploys its different components in *debug* mode. This is useful
for development and testing but it is not adequate for production environments.

Enabling the production mode makes the different components to start caching requests and views and minimizing JavaScript
files.

To enable the production mode, the first step is setting the environment variable *NODE_ENV* to *production* in the machine
containing the Logic Proxy. ::

    $ export NODE_ENV=production

Then, it is needed to collect static files in order to compress JavaScript files. ::

    $ node collect_static.js


Finally, change the setting *DEBUG* of the Charging Backend to False. ::

    DEBUG=False
