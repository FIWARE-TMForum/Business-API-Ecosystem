===================
Configuration Guide
===================

------------
Introduction
------------

This guide covers the different configuration options that are available in order to setup a working Business API
Ecosystem instance. The different Business API Ecosystem components can be configured using two different mecahnisms,
settings files and environment variables.

At this step, the different components of the Business API Ecosystem are installed. In the case of the TMForum APIs and
the RSS, this installation process has already required to configure their database connection before their deployment,
so they are already configured. Nevertheless, this section contains an explanation of the function of the different
settings of the RSS properties files.

------------------------
Configuring the TMF APIs
------------------------

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

The file *oauth.properties* contains by default the following fields (It is recommended not to modify them) ::

    config.grantedRole=Provider
    config.sellerRole=Seller
    config.aggregatorRole=aggregator

This file contains the name of the roles (registered in the idm) that are going to be used by the RSS.

* config.grantedRole: Role in the IDM of the users with admin privileges
* config.sellerRole: Role in the IDM of the users with seller privileges
* config.aggregatorRole: Role of the users who are admins of an store instance. In the context of the Business API Ecosystem there is only a single store instance, so you can safely ignore this flag

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

This settings points to the different APIs accessed by the charging backend. In particular:

* SITE: External URL of the complete Business API Ecosystem using for Href creation
* LOCAL_SITE: URL where the Charging Backend is going to run
* CATALOG: URL of the catalog API including its path
* INVENTORY: URL of the inventory API including its path
* ORDERING: URL of the ordering API including its path
* BILLING: URL of the billing API including its path
* RSS: URL of the RSS including its path
* USAGE: URL of the Usage API including its path
* AUTHORIZE_SERVICE: Complete URL of the usage authorization service. This service is provided by the logic proxy, and is used to generate API Keys to be used by accounting systems when providing usage information.

Once the services have been configured, the next step is configuring the database. In this case, the charging backend uses
MongoDB, and its connection can be configured modifying the *DATABASES* setting of the *settings.py* file. ::

    DATABASES = {
        'default': {
            'ENGINE': 'django_mongodb_engine',
            'NAME': 'wstore_db',
            'USER': '',
            'PASSWORD': '',
            'HOST': '',
            'PORT': '',
            'TEST_NAME': 'test_database',
        }
    }

This setting contains the following fields:

* ENGINE: Database engine, must be fixed to django_mongodb_engine
* NAME: Name of the database to be used
* USER: User of the database. If empty the software creates a non authenticated connection
* PASSWORD: Database user password. If empty the software creates a non authenticated connection
* HOST: Host of the database. If empty it uses the default *localhost* host
* PORT: Port of the database. If empty it uses the default *27017* port
* TEST_NAME: Name of the database to be used when running the tests

Once the database connection has been configured, the next step is configuring the name of the IdM roles to be used by
updating *settings.py* ::

    ADMIN_ROLE = 'provider'
    PROVIDER_ROLE = 'seller'
    CUSTOMER_ROLE = 'customer'

This settings contain the following values:

* ADMIN_ROLE: IDM role of the system admin
* PROVIDER_ROLE: IDM role of the users with seller privileges
* CUSTOMER_ROLE: IDM role of the users with customer privileges

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

.. note::
    The email configuration in optional. However, the field WSTOREMAIL must be provided since it is used internally for RSS configuration

Additionally, the Charging Backend is the component that charges customers and pays providers. For this purpose it uses
PayPal. For configuring paypal, the first step is setting *PAYMENT_METHOD* to *paypal* in the *settings.py* file ::

    PAYMENT_METHOD = 'paypal'

Then, it is required to provide PayPal application credentials by updating the file *src/wstore/charging_engine/payment_client/paypal_client.py* ::

    PAYPAL_CLIENT_ID = ''
    PAYPAL_CLIENT_SECRET = ''
    MODE = 'sandbox'  # sandbox or live

This settings contain the following values:

* PAYPAL_CLIENT_ID: Id of the application provided by PayPal
* PAYPAL_CLIENT_SECRET: Secret of the application provided by PayPal
* MODE: Mode of the connection. It can be *sandbox* if using the PayPal sandbox for testing the system. Or *live* if using the real PayPal APIs

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

    $ ./manage.py crontab add

It is also possible to show current jobs or remove jobs using the commands:
::

    $ ./manage.py crontab show

    $ ./manage.py crontab remove

Configure Apache for running the Charging Backend
-------------------------------------------------

The Charging Backend is a Django App that can be deployed in different ways. In this case, this installation guide covers
two different mechanisms: using the Django *runserver* command (as seen in *Running the Charging Backend* section) or
deploying it using an Apache server. This section explains how to configure Apache and the Charging Backend to do the later.

The first step is installing Apache and mod-wsgi. In Ubuntu/Debian: ::

    $ sudo apt-get install apache2 libapache2-mod-wsgi

Or in CentOS: ::

    $ sudo yum install httpd mod_wsgi

The next step is populating the file *src/wsgi.py* provided with the Charging Backend ::

    import os
    import sys

    path = 'charging_path/src'
    if path not in sys.path:
        sys.path.insert(0, path)

    os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'

    import django.core.handlers.wsgi
    application = django.core.handlers.wsgi.WSGIHandler()

If you are using a virtualenv, then you will need to include its activation in your *wsgi.py* file, so it should look
similar to the following: ::

    import os
    import sys
    import site

    site.addsitedir('virtualenv_path/local/lib/python2.7/site-packages')
    path = 'charging_path/src'
    if path not in sys.path:
        sys.path.insert(0, path)

    os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'

    # Activate your virtual env
    activate_env=os.path.expanduser('virtualenv_path/bin/activate_this.py')
    execfile(activate_env, dict(__file__=activate_env))

    import django.core.handlers.wsgi
    application = django.core.handlers.wsgi.WSGIHandler()

.. note::
    Pay special attention to *charging_path* and *virtualenv_path* which have to point to the Charging Backend and the
    virtualenv paths respectively.

Once WSGI has been configured in the Charging Backend, the next step is creating a vitualhost in Apache. To do that, you
can create a new site configuration file in the Apache related directory (located in */etc/apache2/sites-available/*
in an Ubuntu/Debian system or in */etc/httpd/conf.d* in a CentOS system) and populate it with the following content: ::

    <VirtualHost *:8006>
        WSGIDaemonProcess char_process
        WSGIScriptAlias / charging_path/src/wsgi.py
        WSGIProcessGroup char_process
        WSGIPassAuthorization On

        WSGIApplicationGroup %{GLOBAL}
    </VirtualHost>

.. note::
    Pay special attention to *charging_path* which have to point to the Charging Backend path.

Depending on the version of Apache you are using, you may need to explicitly allow the access to the directory where
the Charging Backend is deployed in the configuration of the virtualhost. To do that, add the following lines to your virtualhost:

Apache version < 2.4 ::

    <Directory charging_path/src>
        Order deny,allow
        Allow from all
    </Directory>


Apache version 2.4+ ::

    <Directory charging_path/src>
        Require all granted
    </Directory>

Once you have included the new virtualhost configuration, the next step is configuring Apache to listen in the selected
port (8006 in the example). To do that, edit */etc/apache2/ports.conf* in Ubuntu/Debian or */etc/httpd/conf/httpd.conf*
in CentOS and include the following line: ::

    Listen 8006

Then, in Ubuntu/Debian systems, enable the site by linking the configuration file to the *sites-enabled* directory: ::

    ln -s ../sites-available/001-charging.conf ./sites-enabled/001-charging.conf

Once you have the site enabled, restart Apache. In Ubuntu/Debian ::

    $ sudo service apache2 restart

Or in CentOS ::

    $ sudo apachectl restart

.. note::
    Ensure that the directory where the Changing Backend is installed can be accessed by the Apache user (www-data in
    Ubuntu/Debian, and apache in CentOS)

---------------------------
Configuring the Logic Proxy
---------------------------

Configuration of the Logic Proxy is located at *config.js* and can be provided in two different ways: providing the values
in the file or using the defined environment variables. Note that the environment variables override the values in *config.js*.

The first setting to be configured is the port and host where the proxy is going to run, this settings are located in *config.js* ::

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

Then, it is possible to modify some of the URLs of the system. Concretely, it is possible to provide a prefix for the API,
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

Additionally, the proxy is the component that acts as the front end of the Business API Ecosystem, both providing a web portal,
and providing the endpoint for accessing to the different APIs. In this regard, the Proxy has to have the OAuth2 configuration
of the FIWARE IDM.

To provide OAUth2 configuration, an application has to be created in an instance of the FIWARE IdM (e.g `https://account.lab.fiware.org`),
providing the following information:

* URL: http|https://<proxy_host>:<proxy_port>
* Callback URL: http|https://<PROXY_HOST>:<PROXY_PORT>/auth/fiware/callback
* Create a role *Seller*, a role *Admin*, and a role *orgAdmin*

Once the application has been created in the IdM, it is possible to provide OAuth2 configuration by modifying the following settings ::

    config.oauth2 = {
        'server': 'https://account.lab.fiware.org',
        'clientID': '<client_id>',
        'clientSecret': '<client_secret>',
        'callbackURL': 'http://<proxy_host>:<proxy_port>/auth/fiware/callback',
        'isLegacy': false,
        'roles': {
            'admin': 'admin',
            'customer': 'customer',
            'seller': 'seller',
            'orgAdmin': 'orgAdmin'
        }
    };

In this settings, it is needed to include the IDM instance being used (*server*), the client id given by the IdM (*clientID*),
the client secret given by the IdM (*clientSecret*), and the callback URL configured in the IdM (*callbackURL*).

In addition, the different roles allow to specify what users are admins of the system (*Admin*), what users can create products
and offerings (*Seller*), and what users are admins of a particular organization, enabling to manage its information (*orgAdmin*).
Note that while *admin* and *seller* roles are granted directly to the users in the Business API Ecosystem application, the *orgAdmin*
role has to be granted to users within IdM organizations.

.. note::
    Admin, Seller, and orgAdmin roles are configured in the Proxy settings, so any name can be chosen for them in the IDM

The *isLegacy* flag is used to specify whether the configured IDM is version 6 or lower, by default this setting is false. 

The OAuth2 settings cane be configured using the environment as follows: ::

    export BAE_LP_OAUTH2_SERVER=https://account.lab.fiware.org
    export BAE_LP_OAUTH2_CLIENT_ID=client_id
    export BAE_LP_OAUTH2_CLIENT_SECRET=client_secret
    export BAE_LP_OAUTH2_CALLBACK=http://<proxy_host>:<proxy_port>/auth/fiware/callback
    export BAE_LP_OAUTH2_ADMIN_ROLE=admin
    export BAE_LP_OAUTH2_SELLER_ROLE=seller
    export BAE_LP_OAUTH2_ORG_ADMIN_ROLE=orgAdmin

    export BAE_LP_OAUTH2_IS_LEGACY=false

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

Finally, there are two fields that allow to configure the behaviour of the system while running. On the one hand, *config.revenueModel*
allows to configure the default percentage that the Business API Ecosystem is going to retrieve in all the transactions.
On the other hand, *config.usageChartURL* allows to configure the URL of the chart to be used to display product usage to
customers in the web portal. They can be configured with environment variables with *BAE_LP_REVENUE_MODEL* and *BAE_LP_USAGE_CHART*