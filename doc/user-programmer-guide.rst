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

Manage Product Offerings
------------------------

Product Offerings are the entities that contain the pricing models and revenue sharing info used to monetize a product specification.
To list your product offerings, go to *My Stock* section and click on *Offerings*

.. image:: /images/user/offering1.png
   :align: center

The existing product offerings can be filtered by status or by if they are a bundle or not. To filter offerings click on
*Filters* choose the appropriate ones and click on *Close*

.. image:: /images/user/offering2.png
   :align: center

.. image:: /images/user/offering3.png
   :align: center

Additionally, it is possible to switch between the grid view and the tabular view by clicking on the specific button.

.. image:: /images/user/offering4.png
   :align: center

.. image:: /images/user/offering5.png
   :align: center

To create a new offering click on *New*

.. image:: /images/user/offering6.png
   :align: center

In the displayed form, include the basic info of the offering. Including, its name, version, an optional description, and
an optional set of places where the offering is available. Once the information has been provided click on *Next*

.. image:: /images/user/offering7.png
   :align: center

In the next step, you can choose whether your offering is a bundle or not. In this case, offering bundles are logical
containers that allow you to provide new pricing models when a set of offerings are acquired together. Once selected click
on *Next*

.. image:: /images/user/offering8.png
   :align: center

If you want to create a bundle you will be required to include at least two bundled offerings.

.. image:: /images/user/offering9.png
   :align: center

In the next step you have to select the product specification that is going to be monetized in the current offering. Once
selected click on *Next*.

.. image:: /images/user/offering10.png
   :align: center

.. note::
   If you are creating an offering bundle, you will not be allowed to include a product specification

Then, you have to select the catalog where you want to publish you offering and click on *Next*

.. image:: /images/user/offering11.png
   :align: center

In the next step, you can optionally choose categories for you offering. Once done, click on *Next*

.. image:: /images/user/offering12.png
   :align: center

The next step is the more important for the offering. In the displayed form you can create different price plans for
you offering, which will be selectable by customers when acquiring the offering. If you do not include any price plan
the offering in considered free.

To include a new price plan the first step is clicking on *New Price Plan*

.. image:: /images/user/offering13.png
   :align: center

For creating the price plan, you have to provide a name, and an optional description. Then, you have to choose the type
of price plan between the provided options.

The available types are: *one time* for payments that are made once when purchasing the offering, *recurring* for charges
that are made periodically (e.g a monthly payment), and *usage* for charges that are calculated applying the pricing model
to the actual usage made of the acquired service.

If you choose *one time*, you have to provide the price and the currency.

.. image:: /images/user/offering14.png
   :align: center

If you choose *recurring*, you have to provide the price, the currency, and the period between charges.

.. image:: /images/user/offering15.png
   :align: center

If you choose usage, you have to provide the unit to be accounted, the currency, and the price per unit

.. image:: /images/user/offering16.png
   :align: center

You can update or remove plans by clicking on the corresponding action button.

.. image:: /images/user/offering17.png
   :align: center

Once you have created you pricing model click on *Next*

.. image:: /images/user/offering18.png
   :align: center

In the last step of the process, you have to choose the revenue sharing model to be applied to you offering between the
available ones. Once done, click on *Next* and then on *Create*.

.. image:: /images/user/offering19.png
   :align: center

.. image:: /images/user/offering20.png
   :align: center

Sellers can also edit their offerings. To do that click on the offering to be updated.

.. image:: /images/user/offering21.png
   :align: center

In the displayed form, change the fields you want to edit and click on *Update*. Note that for start selling you offering
you have to update its status to *Launched*

.. image:: /images/user/offering22.png
   :align: center

Manage Revenue Sharing Models
-----------------------------

Revenue Sharing Models specify how the revenues generated by an offering or set of offerings must be distributed between,
the owner of the Business API Ecosystem instance, the provider of the offering, and the related stakeholders involved.

To manage RS models go to the *Revenue Sharing* section.

.. image:: /images/user/revenue1.png
   :align: center

In this view, you can see the revenue sharing models you have available. By default it will appear the default RS model
which establishes the revenue distribution between you and the Business API Ecosystem instance owner.

.. image:: /images/user/revenue2.png
   :align: center

You can create a new RS model clicking on *New*

.. image:: /images/user/revenue3.png
   :align: center

In the first step of the process you have to provide a product class, which identifies the RS model, and the percentage
you want to receive. The platform percentage is fixed and cannot be modified. Once provided click on *Next*

.. image:: /images/user/revenue4.png
   :align: center

In the next step, you can optionally add more stakeholders to the RS model. To do that click on *Add Stakeholder*

.. image:: /images/user/revenue5.png
   :align: center

Then, select the Stakeholder between the available users, and provide its percentage. Finally, save it clicking on *Add Stakeholder*

.. image:: /images/user/revenue6.png
   :align: center

.. note::
   The total percentage (provider + platform + stakeholders) must be equal to 100

Finally, click on *Next* and then on *Create*

.. image:: /images/user/revenue7.png
   :align: center

.. image:: /images/user/revenue8.png
   :align: center

Sellers can also update their RS model. To do that click on the RS model to be updated.

.. image:: /images/user/revenue9.png
   :align: center

Then, update the required fields (including the stakeholders if you want), and click on *Save Changes*

.. image:: /images/user/revenue10.png
   :align: center

Manage Transactions
-------------------

Manage Received Orders
----------------------

Customer
========

All of the users of the system have by default the *Customer* role. Customers are able to create orders for acquiring
offerings.

List Available Offerings
------------------------

All the available (*Launched*) offerings appear in the *Home* page of the Business API Ecosystem, so they can be seen by
customers.

.. image:: /images/user/search1.png
   :align: center

Additionally, customers can select an specific catalog of offerings by clicking on it.

.. image:: /images/user/search2.png
   :align: center

.. image:: /images/user/search3.png
   :align: center

Moreover, customers can filter the shown offerings by category using the categories dropdown and choosing the wanted one.

.. image:: /images/user/search4.png
   :align: center

Finally, customers can also filter bundle or single offerings using the *Filters* modal.

.. image:: /images/user/search5.png
   :align: center

.. image:: /images/user/search6.png
   :align: center

Customers can open the details of an offering by clicking on it

.. image:: /images/user/search7.png
   :align: center

In the displayed view, it is shown the general info about the offering and its included product, the characteristics of
the product, the price plans of the offering, and the existing relationships.

.. image:: /images/user/search8.png
   :align: center

.. image:: /images/user/search9.png
   :align: center

.. image:: /images/user/search10.png
   :align: center

Create Order
------------

Customers can create orders for acquiring offerings. The different offerings to be included in an order are managed using
the *Shopping Cart*.

To include an offering in the shopping cart there are two possibilities. You can click on the *Add to Cart* button located
in the offering panel when searching, or you can click on the *Add to Cart* button located in the offering details view.

.. image:: /images/user/order1.png
   :align: center

.. image:: /images/user/order2.png
   :align: center

If the offering has configurable characteristics or multiple price plans, a modal will be displayed where you can select
your preferred options

.. image:: /images/user/order3.png
   :align: center

.. image:: /images/user/order4.png
   :align: center

Once you have selected your preferences for the offering click on *Add to Cart*

.. image:: /images/user/order5.png
   :align: center

Once you have included all the offerings you want to acquire to the shopping cart, you can create the order clicking on
*Shopping Cart*, and then on *Checkout*

.. image:: /images/user/order6.png
   :align: center

In the displayed form, you can include an optional name, an optional description, or an optional note. Notes can include
any additional information you want to provide to the sellers of the acquired offerings.

Then, you have to choose a priority for your order, and select one of your shipping addresses.

Once you have provided all the required information you can start the order creation clicking on *Checkout*

.. image:: /images/user/order7.png
   :align: center

In the next step, you will be redirected to *PayPal* so you can pay for the offerings according to their pricing models

.. image:: /images/user/order8.png
   :align: center

Finally, you will see a confirmation page

.. image:: /images/user/order9.png
   :align: center

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


