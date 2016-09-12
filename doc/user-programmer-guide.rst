=========================
User and Programmer Guide
=========================

------------
Introduction
------------

This user and programmer guide covers the Business API Ecosystem version 0.1, corresponding to FIWARE release 5.4.3.
Any feedback on this document is highly welcomed, including bugs, typos or things you think should be included but aren't. Please send them to the "Contact Person" email that appears in the `Catalogue page for this GEi`_.
Or create an issue at `GitHub Issues`_

.. _Catalogue page for this GEi: http://catalogue.fiware.org
.. _GitHub Issues: https://github.com/FIWARE-TMForum/Business-API-Ecosystem/issues/new

----------
User Guide
----------

This user guide contains a description of the different tasks that can be performed in the Business API Ecosystem using
its web interface. This section is organized so the actions related to a concrete user role are grouped together.

Profile Configuration
=====================

All the users of the system can configure their profile, so they can configure their personal information as well as their
billing addresses and contact mediums.

To configure the user profile, the first step is opening the user *Settings* located in the user menu.

.. image:: /images/user/profile1.png
   :align: center

In the displayed view, it can be seen that some information related to account is already included (*Username*, *Email*, *Access token*).
This information is the one provided by the IdM after the login process.

To create the profile, fill in the required information and click on *Update*

.. image:: /images/user/profile2.png
   :align: center

.. note::
   Only the *First name* and *Last name* fields are mandatory

Once you have created your profile, you can include contact mediums by going to the *Contact mediums* section.

.. image:: /images/user/profile3.png
   :align: center

In the *Contact Medium* section, there are two different tabs. On the one hand, the *Shipping addresses* tab, where you
can register the shipping addresses you will be able to use when creating order and purchasing products.

To create a shipping address, fill in the fields and click on *Create*

.. image:: /images/user/profile4.png
   :align: center

Once created, you can edit the address by clicking on the *Edit* button of the specific address, and changing the
wanted fields.

.. image:: /images/user/profile5.png
   :align: center

.. image:: /images/user/profile6.png
   :align: center

On the other hand, if you have the *Seller* role you can create *Business Addresses*, which can be used by your customers
in order to allow them to contact you.

.. image:: /images/user/profile7.png
   :align: center

In the *Business Addresses* tab you can create, different kind of contact mediums, including emails, phones, and addresses.
To create a contact medium, fill in the fields and click on *Create*

.. image:: /images/user/profile8.png
   :align: center

.. image:: /images/user/profile9.png
   :align: center

.. image:: /images/user/profile10.png
   :align: center

You can *Edit* or *Remove* the contact medium by clicking on the corresponding button

.. image:: /images/user/profile11.png
   :align: center

Admin
=====

If the user of the Business API Ecosystem is an admin, he will be able to access the *Administration* section of the
web portal. This section is located in the user menu.

.. image:: /images/user/cat1.png
   :align: center

Manage Categories
-----------------

Admin users are authorized to create the system categories that can be used by *Sellers* to categorize their catalogs,
products, and offerings.

To create categories, go to the *Administration* section, and click on *New*

.. image:: /images/user/cat2.png
   :align: center

Then, provide a name and an optional description for the category. Once the information has been included, click on *Next*, and then on *Create*

.. image:: /images/user/cat3.png
   :align: center

.. image:: /images/user/cat4.png
   :align: center

Categories in the Business API Ecosystem can be nested, so you can choose a parent category if you want, while creating.

.. image:: /images/user/cat5.png
   :align: center

Existing categories can be updated. To edit a category click on the category name.

.. image:: /images/user/cat6.png
   :align: center

Then edit the corresponding fields and click on *Update*.

.. image:: /images/user/cat7.png
   :align: center

Seller
======

If the user of the Business API Ecosystem has the *Seller* role, he will be able to monetize his products by creating,
catalogs, product specifications and product offerings. All these objects are managed accessing *My Stock* section.

.. image:: /images/user/catalog1.png
   :align: center

Manage Catalogs
---------------

The *Catalogs* section is the one that is open by default when the seller accesses *My Stock* section. This section
contains the catalogs the seller has created.

.. image:: /images/user/catalog2.png
   :align: center

Additionally, it is possible to filter the shown catalogs by status and the role you are playing by clicking on *Filters*,
choosing the required ones, and clicking on *Close*

.. image:: /images/user/catalog8.png
   :align: center

.. image:: /images/user/catalog9.png
   :align: center

To create a new catalog click on the *New* button.

.. image:: /images/user/catalog3.png
   :align: center

Then, provide a name and an optional description for the catalog. Once you have filled the fields, click on *Next*, and then on *Create*

.. image:: /images/user/catalog4.png
   :align: center

.. image:: /images/user/catalog5.png
   :align: center

Sellers, can also update their catalogs. To do that, click on the name of the catalog to open the update view.

.. image:: /images/user/catalog6.png
   :align: center

Then update the fields you want to modify and click on *Update*. In this view, it is possible to change the *Status* of the
catalog. To start monetizing the catalog, and make it appear in the *Home* you have to change its status to *Launched*

.. image:: /images/user/catalog7.png
   :align: center

List Provider Product Specs
---------------------------

Create Product Specs
--------------------

Update Product Specs
--------------------

List Provider Offerings
-----------------------

Create Offering
---------------

Update Offering
---------------

List Revenue Sharing Models
---------------------------

Create Revenue Sharing Model
----------------------------

Update Revenue Sharing Model
----------------------------

List Transactions
-----------------

Generate Revenue Sharing Report
-------------------------------

List Revenue Sharing Reports
----------------------------

Manage Received Orders
----------------------

Customer
========

List Available Offerings
------------------------

Create Order
------------

Manage Requested Orders
-----------------------

List Acquired Product
---------------------

Download Assets
---------------

Download Invoices
-----------------

Renew Product
-------------

----------------
Programmer Guide
----------------


