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

Manage Product Specifications
-----------------------------

Product Specifications represent the product being offered, both digital and physical. To list your product specifications
go to *My Stock* section and click on *Product Specifications*

.. image:: /images/user/product1.png
   :align: center

The different product specifications can be filtered by status or by if they are bundles or not. To filter products, click
on *Filters*, choose the appropriate ones, and click on *Close*

.. image:: /images/user/product2.png
   :align: center

.. image:: /images/user/product3.png
   :align: center

Additionally, it is possible to switch between the grid view and the tabular view using the provided buttons.

.. image:: /images/user/product4.png
   :align: center

.. image:: /images/user/product5.png
   :align: center

To create a new product specification click on *New*

.. image:: /images/user/product6.png
   :align: center

In the displayed view, provide the general information of the product spec. including its name, version, and an optional
description. In addition, you have to include the product brand (Your brand), and an ID number which identifies the product
in your environment. Then, click on *Next*.

.. image:: /images/user/product7.png
   :align: center

In the next step, you can choose whether your product specification is a bundle or not. Product bundles are logical containers
that allows you to sell multiple products as if it were a single one. Once you have selected the right option click on *Next*

.. image:: /images/user/product8.png
   :align: center

If you have decided to create a bundle, you will be required to choose 2 or more product specs to be included in the bundle.

.. image:: /images/user/product9.png
   :align: center

In the next step you can choose if your product is a digital product. If this is the case, you will be required to provide
the asset.

.. note::
   If you are creating a product bundle, you will not be allowed to provide a digital asset since the offered ones will
   be the included in the bundled products

For providing the asset, you have to choose between the available asset types, choose how to provide the asset between the
available options, provide the asset, and include its media type.

.. image:: /images/user/product10.png
   :align: center

.. image:: /images/user/product11.png
   :align: center

The next step in the creation of a product is including its characteristics. For including a new characteristic click on
*Add Characteristic*

.. image:: /images/user/product12.png
   :align: center

In the form, include the name, the type (string or number) and an optional description. Then create the values of the
characteristic by filling the *Create a value* input and clicking on *+*.

.. image:: /images/user/product13.png
   :align: center

Once you have included all the characteristic info, save it clicking on *Add Characteristic*

.. image:: /images/user/product14.png
   :align: center

Once you have included all the required characteristics click on *Next*

.. image:: /images/user/product15.png
   :align: center

In the next step you can include a picture for your product spec. You have two options, providing an URL pointing to the
picture or directly uploading it. Once provided click *Next*

.. image:: /images/user/product16.png
   :align: center

.. image:: /images/user/product17.png
   :align: center

In the last step, you can specify relationships of the product you are creating with other of your product specs. Once done
click on *Next* and then on *Create*

.. image:: /images/user/product18.png
   :align: center

.. image:: /images/user/product19.png
   :align: center

Sellers can update their products. To do that click on the product specification to be updated.

.. image:: /images/user/product20.png
   :align: center

Update the required values and click on *Update*. Note that for start selling an offering that includes the product specification
you will be required to change its status to *Launched*

.. image:: /images/user/product21.png
   :align: center

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


