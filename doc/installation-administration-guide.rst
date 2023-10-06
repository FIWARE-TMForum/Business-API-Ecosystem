=====================================
Installation and Administration Guide
=====================================

This guide covers the installation of the Business API Ecosystem (BAE) version 8.1.0. The recommended procedure for the
installation of the Business API Ecosystem is using Docker and the Docker images available in Docker Hub.

Detailed info on how to install the BAE with docker can be found `here <doc:docker-installation-guide>`__

If your system is not dockerized it is possible to deploy the BAE manually following the instructions `here <doc:manual-installation-guide>`__

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
