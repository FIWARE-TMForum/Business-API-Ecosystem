=====================================
Installation and Administration Guide
=====================================

This guide covers the installation of the Business API Ecosystem v7.4.0 from the sources available in GitHub, installing manually
the software dependencies and using the existing scripts for setting up the system.

The current version of the software has been tested under Ubuntu 15.10, Ubuntu 16.04, Ubuntu 18.04, Debian 7, Debian 8,
and CentOS 7. THESE ARE THEREFORE CONSIDERED AS THE SUPPORTED OPERATING SYSTEMS.

.. note::
    The preferred mechanism for the deployment of the Buseiness API Ecosystem is Docker as described in `Docker deployment guide <doc:docker-guide>`__

------------
Installation
------------

Requirements
============

As described in the GEri overview, the Business API Ecosystem is not a single software, but a set of projects that
work together for proving business capabilities. In this regard, this section contains the basic dependencies of
the different components that made up the Business API Ecosystem.

.. note::
    These dependencies are not mean to be installed manually in this step, as they will be installed throughout the documentation

TM Forum APIs and RSS requirements
----------------------------------

* Java 8
* Glassfish 4.1
* MySQL 5.7

Charging Backend requirements
-----------------------------

* Python 2.7
* MongoDB
* wkhtmltopdf

Logic Proxy requirements
------------------------

* NodeJS 6.9.1+ (Including NPM)


Installing basic dependencies
=============================

Basic dependencies such as Java 8, Glassfish, MySQL, Python, etc. Can be installed using the package management tools
provided by your operating system. However, in order to easy the installation process some scripts have been provided.

.. note::
    The installation script may override some of the packages already installed in the system. so if you have software with common dependencies you may want to manually resolve them.

Installing basic dependencies using the script
----------------------------------------------

In order to automate the installation of the basic dependencies, the script *setup_env.sh* has been provided. This
script, located in the root directory, installs all the needed packages for Ubuntu, Debian, and CentOS systems.

Additionally, this script creates a directory */opt/biz-ecosystem* where Glassfish 4.1 and Node 6.9.1 are downloaded,
creates a */etc/default/rss* directory used later for properties files, and sets up the PATH environment in your .bashrc file.

.. note::
    The installation script changes the owner of all its created directories to your current user

To execute the script, run the following command from the root directory of the project ::

    $ ./setup_env.sh

.. note::
   Do not execute the script using sudo, for those tasks which require root privileges the script will prompt you to provide your sudo password

During the execution of the script you will be prompted some times in order to accept Oracle Java 8 terms and conditions
and to provide MySQL root password.

.. image:: ./images/installation/java-terms.png
   :align: center

.. image:: ./images/installation/mysql-root.png
   :align: center


Installing basic dependencies manually
--------------------------------------

Following, you can find how to install the basic dependencies without using the script. Be aware that some commands require to
be executed as root.

APIs dependencies
+++++++++++++++++

**Java 8 Debian/Ubuntu**

To install Java 8 in a Debian or Ubuntu system, it is needed to include the *webupd8team* repository. In an Ubuntu system this can be done
directly with the following command::

    $ sudo add-apt-repository ppa:webupd8team/java

In the case you have a Debian system the following commands have to be executed ::

    $ sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
    $ sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
    $ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

Then Java 8 can be installed using the following commands::

    $ sudo apt-get update
    $ sudo apt-get install -y oracle-java8-installer
    $ sudo apt-get install -y oracle-java8-set-default

**Java 8 CentOS 7**

For a CentOS 7 system, the installation of Java 8 requires downloading the package from the official site ::

    $ wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-x64.tar.gz"
    $ tar xzf jdk-8u102-linux-x64.tar.gz

Then Java can be installed using *alternatives* ::

    $ sudo alternatives --install /usr/bin/java java /opt/biz-ecosystem/jdk1.8.0_102/bin/java 2
    $ sudo alternatives --config java

    $ sudo alternatives --install /usr/bin/jar jar /opt/biz-ecosystem/jdk1.8.0_102/bin/jar 2
    $ sudo alternatives --install /usr/bin/javac javac /opt/biz-ecosystem/jdk1.8.0_102/bin/javac 2
    $ sudo alternatives --set jar /opt/biz-ecosystem/jdk1.8.0_102/bin/jar
    $ sudo alternatives --set javac /opt/biz-ecosystem/jdk1.8.0_102/bin/javac

**MySQL and Maven Debian/Ubuntu**
Once Java has been installed, the next step is installing MySQL and Maven ::

    $ sudo apt-get install -y mysql-server mysql-client
    $ sudo apt-get install -y maven


**MySQL and Maven CentOS 7**

For installing MySQL in CentOS, it is required to include the related repository before installing it ::

    $ wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
    $ sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
    $ sudo yum update

    $ sudo yum install -y mysql-community-server


Then, for installing Maven ::

    $ sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
    $ sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
    $ sudo yum install -y apache-maven


**Glassfish**
The next step is downloading and extracting Glassfish ::

    $ wget http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip
    $ unzip glassfish-4.1.zip

Finally, it is required to download the MySQL connector for Glassfish and include it within the Glassfish *lib* directory ::

    $ wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.39.tar.gz

    $ gunzip mysql-connector-java-5.1.39.tar.gz
    $ tar -xvf mysql-connector-java-5.1.39.tar

    $ cp mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar glassfish4/glassfish/lib

Charging Backend dependencies
+++++++++++++++++++++++++++++

**Python 2.7 Debian/Ubuntu**

To install Python 2.7 and Pip in a Debian/Ubuntu distribution, execute the following command ::

    $ sudo apt-get install -y python python-pip

**Python 2.7 CentOS**

Python 2.7 is included by default in CentOS 7. To install Pip it is required to include EPEL repository.
All this stuff can be done executing the following commands ::

    $ sudo rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
    $ sudo yum -y update
    $ sudo yum install -y python-pip

**MongoDB Debian/Ubuntu**

To install MongoDB in a Debian/Ubuntu distribution, execute the following command ::

    $ sudo apt-get install -y mongodb

**MongoDB CentOS 7**

To install MongoDB in CentOS it is needed to include its repository first. MongoDB can be installed executing the following commands ::

    $ sudo echo "[mongodb]
    name=MongoDB Repository
    baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
    gpgcheck=0
    enabled=1" > /etc/yum.repos.d/mongodb.repo

    $ sudo yum install -y mongodb-org

**Wkhtmltopdf Debian/Ubuntu**

In Debian and Ubuntu Wkhtmltopdf is included in a package, so it can be directly installed with the following command ::

    $ sudo apt-get install -y wkhtmltopdf

**Wkhtmltopdf CentOS 7**

In CentOS the Wkhtmltopdf RPM package has to be downloaded for installing it ::

    $ wget http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-centos7-amd64.rpm
    $ sudo rpm -ivh wkhtmltox-0.12.1_linux-centos7-amd64.rpm

Logic Proxy Dependencies
++++++++++++++++++++++++

For installing Node and NPM it is needed to download the binaries from the official site and uncompress them ::

    $ wget https://nodejs.org/dist/v6.9.1/node-v6.9.1-linux-x64.tar.xz
    $ tar -xvf node-v6.9.1-linux-x64.tar.xz

Installing the Business API Ecosystem
=====================================

As stated previously, the Business API Ecosystem is composed of different systems that need to be installed separately.
In order to easy this process, it has been created an script **install.py** which can be used to automate the installation.

Installing the Business API Ecosystem using the script
------------------------------------------------------

The script *install.py* is located at the root of the Business API Ecosystem project. This script provides functionality
to automate the installation of the software. Concretely, it downloads all the APIs and components, compiles and deploys
the APIs, and installs python and node libraries.

This script depends on Python3 to work. If you have used the *setup_env.sh* script, Python 3 is already installed.
Otherwise, you can install Python 3 using the following commands:

**Debian/Ubuntu** ::

    $ sudo apt-get install -y python3
    $ sudo apt-get install -y python3-pip

**CentOS 7** ::

    $ sudo yum -y install scl-utils
    $ sudo rpm -Uvh https://www.softwarecollections.org/en/scls/rhscl/python33/epel-7-x86_64/download/rhscl-python33-epel-7-x86_64.noarch.rpm
    $ sudo yum -y install python33

Additionally, *install.py* specs the binaries of Glassfish and Node to be included in the PATH, and need to be accessible
by the user using the script. This can be done with the following commands (Note that the commands are supposing both or them are installed at */opt/biz-ecosystem*) ::

    $ export PATH=$PATH:/opt/biz-ecosystem/glassfish4/glassfish/bin
    $ export PATH=$PATH:/opt/biz-ecosystem/node-6.9.1-linux-x64/bin

    $ sudo chown -R <your_user>:<your_user> /opt/biz-ecosystem

If you have used *setup_env.sh**, the Glassfish installation directory already belongs to your user. In addition, the
export PATH command has been included in your bashrc, so to have Node and Glassfish in the PATH execute the following
command: ::

    $ source ~/.bashrc

Moreover, *install.py* requires Glassfish, MySQL and MongoDB to be up and running.

**Debian/Ubuntu** ::

    $ asadmin start-domain
    $ sudo service mysql restart
    $ sudo service mongodb restart

**CentOS 7** ::

    $ asadmin start-domain
    $ sudo systemctl start mysqld
    $ sudo systemctl start mongod


Finally, during the deployment of the RSS API, the script saves the properties file in the default RSS properties directory.
If you have used *setup_env.sh* this directory already exists. Otherwise, you have to manually create the directory
*/etc/default/rss*, being required to have root privileges to create it. Moreover, this directory must be accessible by
the user executing the script. To do that ::

    $ sudo mkdir /etc/default/rss
    $ sudo chown <your_user>:<your_user> /etc/default/rss

The script *install.py* creates the different databases as well as the connection pools and resources. In this regard,
after the execution of the script all the APIs will be already configured. You can specify the database settings by modifying the
script and updating DBUSER, DBPWD, DBHOST, and DBPORT, which by default contains the following configuration. ::

    DBUSER = "root"
    DBPWD = "toor"
    DBHOST = "localhost"
    DBPORT = 3306

To make a complete installation of the Business API Ecosystem, execute the following command ::

    $ ./install.py all

In addition to the *all* option, *install.py* also provides several options that allows to execute parts of the installation
process, so you can have more control over it. Concretely, the script provides the following options:

* **clone**: Downloads from GitHub the different components of the Business API Ecosystem
* **persistence**: Builds persistence.xml files of the different APIs
* **maven**: Compiles the downloaded APIs using Maven
* **tables**: Creates the required databases in MySQL
* **pools**: Creates database pools in Glassfish
* **resources**: Creates database resources in Glassfish
* **redeploy**: Deploys APIs and RSS war files in Glassfish
* **charging**: Installs charging Python libs
* **proxy**: Installs proxy Node libs

Installing the Business API Ecosystem Manually
----------------------------------------------

Installing TM Forum APIs
++++++++++++++++++++++++

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
    $ git checkout v7.4.0

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
++++++++++++++++++

The RSS sources can be found in `GitHub <https://github.com/FIWARE-TMForum/business-ecosystem-rss>`__

The first step for installing the RSS component is downloading it and moving to the correct release ::

    $ git clone https://github.com/FIWARE-TMForum/business-ecosystem-rss.git
    $ cd business-ecosystem-rss
    $ git checkout v7.4.0

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
+++++++++++++++++++++++++++++++

The Charging Backend sources can be found in `GitHub <https://github.com/FIWARE-TMForum/business-ecosystem-charging-backend>`__

The first step for installing the charging backend component is downloading it and moving to the correct release ::

    $ git clone https://github.com/FIWARE-TMForum/business-ecosystem-charging-backend.git
    $ cd business-ecosystem-charging-backend
    $ git checkout v7.4.0

Once the code has been downloaded, it is recommended to create a virtualenv for installing python dependencies (This is not mandatory). ::

    $ virtualenv virtenv
    $ source virtenv/bin/activate

To install python libs, execute the *python-dep-install.sh* script ::

    $ ./python-dep-install.sh

.. note::
    If you have not created and activated a virtualenv you will need to execute the script using sudo

Installing the Logic Proxy
++++++++++++++++++++++++++

The Logic Proxy sources can be found in`GitHub <https://github.com/FIWARE-TMForum/business-ecosystem-logic-proxy>`__

The first step for installing the logic proxy component is downloading it and moving to the correct release ::

    $ git clone https://github.com/FIWARE-TMForum/business-ecosystem-logic-proxy.git
    $ cd business-ecosystem-logic-proxy
    $ git checkout v7.4.0

Once the code has been downloaded, Node dependencies can be installed with the provided script as follows ::

    $ ./install.sh

Upgrading from 5.4.1
====================

For upgrading Business API Ecosystem version 5.4.1 installations to version 7.4.0 a new command has been incorporated
within the *install.py* script. This command downloads new components software, updates it, and  migrates the
different databases, so it lets the software ready to be used.

.. note::
    It is highly recommended to make a backup of the different databases before upgrading the software

The first step for upgrading the Business API Ecosystem is downloading new version of the main repository in order to
update installation scripts. ::

    cd Business-API-Ecosystem
    git fetch
    git checkout v7.4.0
    git pull origin v7.4.0

The new version of *install.py* has a new dependency (PyMSQL) that has to be manually solved in order to execute
the upgrading command. ::

    $ pip3 install pymysql

Once the main repository is upgraded, the next step is using the provided script for upgrading the software. ::

    $ ./install.py upgrade

This command do not change your configuration parameters. Nevertheless, you should review the *Configuration* section
as new settings has been included.

The *upgrade* command uses a set of new commands that have been incorporated within *install.py* in order to manage the
upgrade. In particular:

* **download**: Downloads the new software for the different components of the Business API Ecosystem
* **dump**: Creates a dump of the different MySQL databases within */tmp*
* **migrate**: Migrates database contents from v5.4.1 to v7.4.0

-----------
Final steps
-----------

Media and Indexes
=================

The Business API Ecosystem, allows to upload some product attachments and assets to be sold. These assets are uploaded
by the Charging Backend that saves them in the file system, jointly with the generated PDF invoices.

In this regard, the directories *src/media*, *src/media/bills*, and *src/media/assets* must exist within the Charging Backend directory, and must
be writable by the user executing the Charging Backend. ::

    $ mkdir src/media
    $ mkdir src/media/bills
    $ mkdir src/media/assets
    $ chown -R <your_user>:<your_user> src/media

Additionally, the Business API Ecosystem uses indexes for efficiency and pagination. In this regards, the directory *indexes* must
exist within the Logic Proxy directory, and must be writable by the user executing it. ::

    $ mkdir indexes
    $ chown -R <your_user>:<your_user> indexes

You can populate at any time the indexes directory using the *fill_indexes.js* script provided with the Logic Proxy. ::

    $ node fill_indexes.js


----------------------------------
Running the Business API Ecosystem
----------------------------------

Running the APIs and the RSS
============================

Both the TM Forum APIs and the RSS are deployed in Glassfish; in this regard, the only step for running them is starting
Glassfish ::

    $ asadmin start-domain

Running the Charging Backend
============================

The Charging Backend creates some objects and connections on startup; in this way, the Glassfish APIs must be up an running
before starting it.

**Using Django runserver**

The Charging Backend can be started using the *runserver* command provided with Django as follows ::

    $ ./manage.py runserver 127.0.0.1:<charging_port>

Or in background ::

    $ nohup ./manage.py runserver 127.0.0.1:<charging_port> &

.. note::
    If you have created a virtualenv when installing the backend or used the installation script, you will need to activate the
    virtualenv before starting the Charging Backend

**Using Apache**

If you have deployed the charging backend in Apache, you can stat it with the following command in a Debian/Ubuntu system ::

    $ sudo service apache2 start

Or in a CentOS system ::

    $ sudo apachectl start

Running the Logic Proxy
=======================

The Logic Proxy can be started using Node as follows ::

    $ node server.js

Or if you want to start it in background: ::

    $ nohup node server.js &


-----------------------
Sanity check Procedures
-----------------------

The Sanity Check Procedures are the steps that a System Administrator will take to verify that an installation is ready
to be tested. This is therefore a preliminary set of tests to ensure that obvious or basic malfunctioning is fixed before
proceeding to unit tests, integration tests and user validation.

End to End Testing
==================

Please note that the following information is required before starting with the process:
* The host and port where the Proxy is running
* A valid IdM user with the *Seller* role

To Check if the Business API Ecosystem is running, follow the next steps:

1. Open a browser and enter to the Business API Ecosystem
2. Click on the *Sign In* Button

.. image:: ./images/installation/sanity1.png

3. Provide your credentials in the IdM page

.. image:: ./images/installation/sanity2.png

4. Go to the *Revenue Sharing* section

.. image:: ./images/installation/sanity3.png

5. Ensure that the default RS Model has been created

.. image:: ./images/installation/sanity4.png

6. Go to *My Stock* section

.. image:: ./images/installation/sanity5.png

7. Click on *New* for creating a new catalog

.. image:: ./images/installation/sanity6.png

8. Provide a name and a description and click on *Next*. Then click on *Create*

.. image:: ./images/installation/sanity7.png
.. image:: ./images/installation/sanity8.png
.. image:: ./images/installation/sanity9.png

9. Click on *Launched*, and then click on *Update*

.. image:: ./images/installation/sanity10.png
.. image:: ./images/installation/sanity11.png

10. Go to *Home*, and ensure the new catalog appears

.. image:: ./images/installation/sanity12.png
.. image:: ./images/installation/sanity13.png

List of Running Processes
=========================

We need to check that Java for the Glassfish server (APIs and RSS), python (Charging Backend) and Node (Proxy) are running,
as well as MongoDB and MySQL databases. If we execute the following command: ::

    ps -ewF | grep 'java\|mongodb\|mysql\|python\|node' | grep -v grep

It should show something similar to the following: ::

    mongodb   1014     1  0 3458593 49996 0 sep08 ?        00:22:30 /usr/bin/mongod --config /etc/mongodb.conf
    mysql     1055     1  0 598728 64884  2 sep08 ?        00:02:21 /usr/sbin/mysqld
    francis+ 15932 27745  0 65187 39668   0 14:53 pts/24   00:00:08 python ./manage.py runserver 0.0.0.0:8006
    francis+ 15939 15932  1 83472 38968   0 14:53 pts/24   00:00:21 /home/user/business-ecosystem-charging-backend/src/virtenv/bin/python ./manage.py runserver 0.0.0.0:8006
    francis+ 16036 15949  0 330473 163556 0 14:54 pts/25   00:00:08 node server.js
    root      1572     1  0 1142607 1314076 3 sep08 ?      00:37:40 /usr/lib/jvm/java-8-oracle/bin/java -cp /opt/biz-ecosystem/glassfish ...

Network interfaces Up & Open
============================

To check the ports in use and listening, execute the command: ::

    $ sudo netstat -nltp

The expected results must be something similar to the following: ::

    Active Internet connections (only servers)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
    tcp        0      0 127.0.0.1:8006          0.0.0.0:*               LISTEN      15939/python
    tcp        0      0 127.0.0.1:27017         0.0.0.0:*               LISTEN      1014/mongod
    tcp        0      0 127.0.0.1:28017         0.0.0.0:*               LISTEN      1014/mongod
    tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN      1055/mysqld
    tcp6       0      0 :::80                   :::*                    LISTEN      16036/node
    tcp6       0      0 :::8686                 :::*                    LISTEN      1572/java
    tcp6       0      0 :::4848                 :::*                    LISTEN      1572/java
    tcp6       0      0 :::8080                 :::*                    LISTEN      1572/java
    tcp6       0      0 :::8181                 :::*                    LISTEN      1572/java

Databases
=========

The last step in the sanity check, once we have identified the processes and ports, is to check that MySQL and MongoDB
databases are up and accepting queries. We can check that MySQL is working, with the following command: ::

    $ mysql -u <user> -p<password>

You should see something similar to: ::

    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 174
    Server version: 5.5.47-0ubuntu0.14.04.1 (Ubuntu)

    Copyright (c) 2000, 2015, Oracle and/or its affiliates. All rights reserved.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql>

For MongoDB, execute the following command: ::

    $ mongo <database> -u <user> -p <password>

You should see something similar to: ::

    MongoDB shell version: 2.4.9
    connecting to: <database>
    >

--------------------
Diagnosis Procedures
--------------------

The Diagnosis Procedures are the first steps that a System Administrator will take to locate the source of an error in a GE.
Once the nature of the error is identified with these tests, the system admin will very often have to resort to more concrete
and specific testing to pinpoint the exact point of error and a possible solution. Such specific testing is out of the scope
of this section.

Resource Availability
=====================

Memory use depends on the number of concurrent users as well as the free memory available and the hard disk.
The Business API Ecosystem requires a minimum of 1024 MB of available RAM memory, but 2048 MB of free memory are recomended.
Moreover, the Business API Ecosystem requires at least 15 GB of hard disk space.

Remote Service Access
=====================

N/A

Resource Consumption
====================

Resource consumption strongly depends on the load, especially on the number of concurrent users logged in.

* Glassfish main memory consumption should be between 500 MB and 2048 MB
* MongoDB main memory consumption should be between 30 MB and 500 MB
* Pyhton main memory consumption should be between 30 MB and 200 MB
* Node main memory consumption should be between 30 MB and 200 MB
* MySQL main memory consumption should be between 30 MB and 500 MB

I/O Flows
=========

The only expected I/O flow is of type HTTP, on port defined in the Logic Proxy configuration file
