=====================================
Installation and Administration Guide
=====================================

------------
Introduction
------------

This installation and administration guide covers the Business API Ecosystem version 0.1, corresponding to FIWARE release 5.4.3.
Any feedback on this document is highly welcomed, including bugs, typos or things you think should be included but aren't. Please send them to the "Contact Person" email that appears in the `Catalogue page for this GEi`_.
Or create an issue at `GitHub Issues`_

.. _Catalogue page for this GEi: http://catalogue.fiware.org
.. _GitHub Issues: https://github.com/FIWARE-TMForum/Business-API-Ecosystem/issues/new

The current version of the software has been tested under Ubuntu 14.04, Ubuntu 15.10, Ubuntu 16.06, Debian 7, Debian 8,
and CentOS 7. THESE ARE THEREFORE CONSIDERED AS THE SUPPORTED OPERATING SYSTEMS.

------------
Installation
------------

Requirements
============

Installing basic dependencies
=============================

Basic dependencies such as Java 8, Glassfish, MySQL, Python, etc. Can be installed using the package management tools
provided by your operating system. However, in order to easy the installation process some scripts have been provided.

.. note::
    The installation script may override some of the packages already installed in the system. so if you have software with common dependencies you may want to manually resolve them.

Installing basic dependencies using the script
----------------------------------------------

In order to automate the installation of the basic dependencies, the script *resolve-basic-dep.sh* has been provided. This
script, located in the directory *scripts/*, installs all the needed packages for Ubuntu, Debian, and CentOS systems.

Additionally, this script creates a directory */opt/biz-ecosystem* where Glassfish 4.1 and Node 4.5.0 are downloaded.

To execute the script, run the following command from the *scrips/* directory of the project ::

    $ sudo ./resolve-basic-dep.sh

During the execution of the script ypu will be prompted some times in order to accept Oracle Java 8 terms and conditions,
and to provide MySQL root password.

.. image:: /images/installation/java-terms.png
   :align: center

.. image:: /images/installation/mysql-root.png
   :align: center


Installing basic dependencies manually
--------------------------------------

Installing the Business API Ecosystem
=====================================

-------------
Configuration
-------------

-----------
Final steps
-----------

----------------------------------
Running the Business API Ecosystem
----------------------------------

-----------------------
Sanity check Procedures
-----------------------

--------------------
Diagnosis Procedures
--------------------

