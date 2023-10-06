-------------------
Manual Installation
-------------------

Requirements
============

As described in the GEri overview, the Business API Ecosystem is not a single software, but a set of projects that
work together for providing business capabilities. In this regard, this section contains the basic dependencies of
the different components that made up the Business API Ecosystem.

TM Forum APIs and RSS requirements
----------------------------------

* Java 8
* Glassfish 4.1
* MySQL 5.7

Charging Backend requirements
-----------------------------

* Python 3.9
* MongoDB 4.4+
* wkhtmltopdf

Logic Proxy requirements
------------------------

* NodeJS 16+ (Including NPM)
* Elasticsearch 7.5+


Installation
============


Installing TM Forum APIs
------------------------

The different reference implementations of the TM Forum APIs used in the Business API Ecosystem are available in GitHub:

* `Catalog Management API <https://github.com/FIWARE-TMForum/DSPRODUCTCATALOG2>`__
* `Product Ordering Management API <https://github.com/FIWARE-TMForum/DSPRODUCTORDERING>`__
* `Product Inventory Management API <https://github.com/FIWARE-TMForum/DSPRODUCTINVENTORY>`__
* `Party Management API <https://github.com/FIWARE-TMForum/DSPARTYMANAGEMENT>`__
* `Customer Management API <https://github.com/FIWARE-TMForum/DSCUSTOMER>`__
* `Billing Management API <https://github.com/FIWARE-TMForum/DSBILLINGMANAGEMENT>`__
* `Usage Management API <https://github.com/FIWARE-TMForum/DSUSAGEMANAGEMENT>`__

The installation for all of them is similar. The first step is cloning the repository and moving to the correct release ::

    $ git clone https://github.com/FIWARE-TMForum/DSPRODUCTCATALOG2.git
    $ cd DSPRODUCTCATALOG2

Once the software has been downloaded, it is needed to create the connection to the database. To do that, the first step
is editing the *src/main/resources/META-INF/persistence.xml* to have something similar to the following: ::

    <?xml version="1.0" encoding="UTF-8"?>
    <persistence version="2.1" xmlns="http://xmlns.jcp.org/xml/ns/persistence" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence http://xmlns.jcp.org/xml/ns/persistence/persistence_2_1.xsd">
        <persistence-unit name="DSProductCatalogPU" transaction-type="JTA">
            <jta-data-source>jdbc/pcatv2</jta-data-source>
            <exclude-unlisted-classes>false</exclude-unlisted-classes>
            <properties>
                <property name="javax.persistence.schema-generation.database.action" value="drop-and-create"/>
            </properties>
        </persistence-unit>
    </persistence>


Note that you should provide in the tag *jta-data-source* the name you want for your database connection resource, taking into account
that it must be unique for each API.

The next step is creating the database for you API. ::

    $ mysql-u <user> -p<passwd> "CREATE DATABASE IF NOT EXISTS <database>"

.. note::
    You have to provide your own credentials and the selected database name to the previous command.

Once that the database has been created, the next step is creating the connection pool in Glassfish. To do that, you can
use the following command: ::

    $ asadmin create-jdbc-connection-pool --restype java.sql.Driver --driverclassname com.mysql.jdbc.Driver --property user=<user>:password=<passwd>:URL=jdbc:mysql://<host>:<port>/<database> <poolname>

.. note::
    You have to provide you own database credentials, the database host, the database port, the database name of the one created previously, and a name for your pool

The last step for creating the database connection is creating the connection resource. To do that, execute the following command: ::

    $ asadmin create-jdbc-resource --connectionpoolid <poolname> <jndiname>

.. note::
    You have to provide the name of the pool you have previously created and a name for your resource, which has to be the same
    as the included in the *jta-data-source* tag of the *persistence.xml* file of the API.

When the database connection has been created, the next step is compiling the API sources with Maven ::

    $ mvn install

Finally, the last step is deploying the generated war file in Glassfish ::

    $ asadmin deploy --contextroot <root> --name <root> target/<WAR.war>

.. note::
    You have to provide the wanted context root for the API, a name for it, and the path to the war file

Installing the RSS
------------------

The RSS sources can be found in `GitHub <https://github.com/FIWARE-TMForum/business-ecosystem-rss>`__

The first step for installing the RSS component is downloading it and moving to the correct release ::

    $ git clone https://github.com/FIWARE-TMForum/business-ecosystem-rss.git
    $ cd business-ecosystem-rss
    $ git checkout v8.0.0

Then, the next step is coping, *database.properties* and *oauth.properties* files to its default location at */etc/default/rss* ::

    $ sudo mkdir /etc/default/rss
    $ sudo chown <your_user>:<your_user> /etc/default/rss
    $ cp properties/database.properties /etc/default/rss/database.properties
    $ cp properties/oauth.properties /etc/default/rss/ouath.properties

.. note::
    You have to include your user when changing *rss* directory owner

Once the properties files have been copied, they should be edited in order to provide the correct configuration params:

database.properties ::

    database.url=jdbc:mysql://localhost:3306/RSS
    database.username=root
    database.password=root
    database.driverClassName=com.mysql.jdbc.Driver

oauth.properties ::

    config.grantedRole=Provider
    config.sellerRole=Seller
    config.aggregatorRole=aggregator

.. note::
    The different params included in the configuration file are explained in detail in the Configuration section

Once the properties files have been edited, the next step is compiling the sources with Maven ::

    $ mvn install

Finally, the last step is deploying the generated war file in Glassfish ::

    $ asadmin deploy --contextroot DSRevenueSharing --name DSRevenueSharing fiware-rss/target/DSRevenueSharing.war

Installing the Charging Backend
-------------------------------

The Charging Backend sources can be found in `GitHub <https://github.com/FIWARE-TMForum/business-ecosystem-charging-backend>`__

The first step for installing the charging backend component is downloading it and moving to the correct release ::

    $ git clone https://github.com/FIWARE-TMForum/business-ecosystem-charging-backend.git
    $ cd business-ecosystem-charging-backend

Once the code has been downloaded, it is recommended to create a virtualenv for installing python dependencies (This is not mandatory). ::

    $ virtualenv virtenv
    $ source virtenv/bin/activate

To install python dependecies use pip tool ::

    $ pip3 install -r requirements.txt

If you are planning to run the tests or develop, you should install the development dependecies: ::

    $ pip3 install -r dev-requirements.txt


Installing the Logic Proxy
--------------------------

The Logic Proxy sources can be found in `GitHub <https://github.com/FIWARE-TMForum/business-ecosystem-logic-proxy>`__

The first step for installing the logic proxy component is downloading it and moving to the correct release ::

    $ git clone https://github.com/FIWARE-TMForum/business-ecosystem-logic-proxy.git
    $ cd business-ecosystem-logic-proxy

Once the code has been downloaded, Node dependencies can be installed with NPM ::

    $ npm install


Final steps
===========

Media and Indexes
-----------------

The Business API Ecosystem, allows to upload some product attachments and assets to be sold. These assets are uploaded
by the Charging Backend that saves them in the file system, jointly with the generated PDF invoices.

In this regard, the directories *src/media*, *src/media/bills*, and *src/media/assets* must exist within the Charging Backend directory, and must
be writable by the user executing the Charging Backend. ::

    $ mkdir src/media
    $ mkdir src/media/bills
    $ mkdir src/media/assets
    $ chown -R <your_user>:<your_user> src/media

Additionally, the Business API Ecosystem uses Elasticsearch indexes for efficiency and pagination. You can populate at any time the indexes
directory using the *fill_indexes.js* script provided with the Logic Proxy. ::

    $ node fill_indexes.js

Running the Business API Ecosystem
==================================

Running the APIs and the RSS
----------------------------

Both the TM Forum APIs and the RSS are deployed in Glassfish; in this regard, the only step for running them is starting
Glassfish ::

    $ asadmin start-domain

Running the Charging Backend
----------------------------

The Charging Backend creates some objects and connections on startup; in this way, the Glassfish APIs must be up an running
before starting it.

**Using Django runserver**

The Charging Backend can be started using the *runserver* command provided with Django as follows ::

    $ python3 manage.py runserver 127.0.0.1:<charging_port>

.. note::
    If you have created a virtualenv when installing the backend or used the installation script, you will need to activate the
    virtualenv before starting the Charging Backend

**Using Gunicorn*

The Charging Backend can be deployed in production using Gunicorn. To do that execute the following command ::

    $ gunicorn wsgi:application --workers 1 --forwarded-allow-ips "*" --log-file - --bind 0.0.0.0:8006 --log-level INFO


Running the Logic Proxy
-----------------------

The Logic Proxy can be started using Node as follows ::

    $ node server.js
