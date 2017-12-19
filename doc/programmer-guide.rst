================
Programmer Guide
================

Introduction
============

This programmer guide covers the Business API Ecosystem version 6.4.0, corresponding to FIWARE release 6.
Any feedback on this document is highly welcomed, including bugs, typos or things you think should be included but aren't.
Please send them to the "Contact Person" email that appears in the `Catalogue page for this GEi`_. Or create an issue at `GitHub Issues`_

.. _Catalogue page for this GEi: https://catalogue.fiware.org/enablers/business-api-ecosystem-biz-ecosystem-ri
.. _GitHub Issues: https://github.com/FIWARE-TMForum/Business-API-Ecosystem/issues/new

The Business API Ecosystem allows to offer any kind of digital asset. In this regard, some kind of digital assets may
require to perform specific actions and validations that require to know the format of the asset. To deal with this
issue the Business API Ecosystem allows to register types of assets by creating plugins. This section explains how these plugins are created.

Additionally, the Business API Ecosystem exposes an API that can be used by developers in order to integrate the monetization
features offered with their own solutions. The complete description of this API can be found in:


* `Apiary <http://docs.fiwaretmfbizecosystem.apiary.io>`__
* `GitHub Pages <https://fiware-tmforum.github.io/Business-API-Ecosystem/>`__


Plugin Package
==============

Business API Ecosystem plugins must be packaged in a zip. This file will contain all the sources of the plugin and a
configuration file called *package.json* in the root of the zip. This configuration file allows to specify some aspects
of the behaviour of the plugin and contains the following fields:

* name: Name given to the resource type. This is the field that will be shown to providers
* author: Author of the plugin.
* formats: List that specify the different allowed formats for providing an asset of the given type. This list can contain the values "URL" and "FILE".
* module: This field is used to specify the main class of the Plugin.
* version: Current version of the plugin.
* media_types: List of allowed media types that can be selected when providing an asset of the given type
* pull_accounting (optional): This flag is used to indicate that the service defined by the plugin is not pushing accounting
  information to the usage API of the Business API Ecosystem, but exposing an API that must be queried to retrieve this information.
* form (optional): This field is used to define a custom form that will be displayed for retrieving asset-specific meta data.
  This field is defined as an object where keys are the name of the metadata property and values define the following information:

  * type: Type of the particular metadata property. Allowed values are *text*, *textarea*, *checkbox* and *select* mapping
    the form input types to be displayed for retrieving the data.
  * label: Label to be displayed jointly with the form input.
  * default: Default value to be used if no value provided for the property
  * placeholder (text and textarea): Placeholder to be included within the form input
  * options (select): List of valid options when the input is a select. It includes *text* and *value* for each entry.


Following you can find an example of a *package.json* file:

::

    {
        "name": "Test Resource",
        "author": "fdelavega",
        "formats": ["FILE"],
        "module": "plugin.TestPlugin",
        "version": "1.0",
        "media_types": ["application/zip"],
        "form": {
            "auth_type": {
                "type": "select",
                "label": "Auth type",
                "options": [{
                    "text": "OAuth2",
                    "value": "oauth2"
                }, {
                    "text": "API Key",
                    "value": "key"
                }]
            },
            "token_required": {
                "type": "checkbox",
                "label": "Token required?",
                "default": true
            },
            "auth_server": {
                "type": "text",
                "label": "Auth Server",
                "placeholder": "https://authservice.com/auth"
            }
        }
    }

The source code of the plugin must be written in Python and must contain a main class that must be a child class of
the Plugin class defined in the Charging Backend of the Business API Ecosystem. Following you can find an example of a plugin main class.

::

    from wstore.asset_manager.resource_plugins.plugin import Plugin

    class TestPlugin(Plugin):
        def on_pre_product_spec_validation(self, provider, asset_t, media_type, url):
            pass

        def on_post_product_spec_validation(self, provider, asset):
            pass

        def on_pre_product_spec_attachment(self, asset, asset_t, product_spec):
            pass

        def on_post_product_spec_attachment(self, asset, asset_t, product_spec):
            pass

        def on_pre_product_spec_upgrade(self, asset, asset_t, product_spec):
            pass

        def on_post_product_spec_upgrade(self, asset, asset_t, product_spec):
            pass

        def on_pre_product_offering_validation(self, asset, product_offering):
            pass

        def on_post_product_offering_validation(self, asset, product_offering):
            pass

        def on_product_acquisition(self, asset, contract, order):
            pass

        def on_product_suspension(self, asset, contract, order):
            pass

        def get_usage_specs(self):
            return []

        def get_pending_accounting(self, asset, contract, order):
            return [], Date()


Implementing Event Handlers
===========================

It can be seen in the previous section that the main class of a plugin can implement some methods that are inherited from
the Charging Backend Plugin class. This methods can be used to implement handlers of the different events of the life cycle
of a product containing the asset. Concretely, the following events have been defined:

* **on_pre_product_spec_validation**: This method is executed when creating a new digital product containing an asset of
  the given type, before validating the product spec contents and saving the asset info in the database. This method can
  be used for validating the asset format or the seller permissions to sell the asset.
* **on_post_product_spec_validation**: This method is executed when creating a new digital product containing an asset
  of the given type, after validating the product spec and saving the asset info in the database. This method can be used
  if the plugin require to know some specific info of the asset model
* **on_pre_product_spec_attachment**: This method is executed when creating a new digital product containing an asset of
  the given type, after saving the product spec in the catalog API database but before attaching the product spec id to
  the asset model. This method can be used if the plugin require to know the id in the catalog of the product spec
* **on_post_product_spec_attachment**: This method is executed when creating a new digital product containing an asset of
  the given type, after saving the product spec in the catalog API database and after attaching the product spec id to the
  asset model. This method can be used if the plugin require to know the id in the catalog of the product spec
* **on_pre_product_spec_upgrade**: This method is executed when a digital product is being upgraded (a new version of the
  asset has been provided). This method can be used in order to validate the new digital asset before saving the upgrade
* **on_post_product_spec_upgrade**: This method is executed when a digital product have been upgraded. This method can be
  used to send notifications or retrieve new information of the product specification.
* **on_pre_product_offering_validation**: This method is executed when creating a new product offering containing an asset
  of the given type, before validating its pricing model. This method can be used to make extra validations on the pricing
  model, for example check if the unit of an usage model is supported by the given asset
* **on_post_product_offering_validation**: This method is executed when creating a new product offering containing an
  asset of the given type, after validating its pricing model. This method can be used to make extra validations on the
  pricing model, for example check if the unit of an usage model is supported by the given asset
* **on_product_acquisition**: This method is called when a product containing an asset of the given type has been acquired.
  This method can be used to activate the service for the customer and give him access rights.
* **on_product_suspension**: This method is called when a product containing an asset of the given type has been suspended
  for a customer (e.g he has not paid). Tjis method can be used to suspend the service for the customer and remove his
  access rights
* **get_usage_specs**: This method must be implemented when the flag *pull_accounting* is set to true and must return the list
  of usage specifications the service is able to monitor. For each usage specification a *name* and a *description* must be
  provided (e.g name: API Call, description: Number of calls made to...)
* **get_pending_accounting**: This method must be implemented when the flag *pull_accounting* is set to true. This method
  must implement the client able to access to the service the plugin is defining in order to retrieve pending accounting
  information for a giving contract. It must return the list of pending accounting including:

  * *date*: Timestamp of the accounting record
  * *unit*: Monitored unit
  * *value*: Actual usage made by the customer

As can be seen in the Plugin example, the different handler methods receive some parameters with relevant information and
objects. In particular:

on_pre_product_spec_validation
------------------------------

* **provider**: User object containing the user who is creating the product specification (The User object is described later)
* **asset_t**: String containing the asset type, it must be equal to the one defined in package.json
* **media_type**: String containing the media type of the asset included in the product being created
* **url**: String containing the url of the asset included in the product being created


on_post_product_spec_validation
-------------------------------

* **provider**: User object containing the user who is creating the product specification (The User object is described later)
* **asset**: Asset object with the recently created asset (The Asset object is described later)

on_pre_product_spec_attachment
------------------------------

* **asset**: Asset object where the created product specification id is going to be attached
* **asset_t**: String containing the asset type, it must be equal to the one defined in package.json
* **product_spec**: JSON with the raw product specification information that is going to be used for the attachment. (The structure of this JSON object can be found in the Open Api documentation)


on_post_product_spec_attachment
-------------------------------

* **asset**: Asset object where the created product specification id has been attached
* **asset_t**: String containing the asset type, it must be equal to the one defined in package.json
* **product_spec**: JSON with the raw product specification information that has been used for the attachment. (The structure of this JSON object can be found in the Open Api documentation)

on_pre_product_spec_upgrade
---------------------------

* **asset**: Asset object that have been upgraded
* **asset_t**: String containing the asset type, it must be equal to the one defined in package.json
* **product_spec**: JSON with the raw product specification information that is going to be used for the upgrade. (The structure of this JSON object can be found in the Open Api documentation)


on_post_product_spec_upgrade
----------------------------

* **asset**: Asset object that have been upgraded
* **asset_t**: String containing the asset type, it must be equal to the one defined in package.json
* **product_spec**: JSON with the raw product specification information that has been used for the upgrade. (The structure of this JSON object can be found in the Open Api documentation)


on_pre_product_offering_validation
----------------------------------

* **asset**: Asset object included in the offering being created
* **product_offering**: JSON with the raw product offering information that is going to be validated. (The structure of this JSON object can be found in the Open Api documentation)


on_post_product_offering_validation
-----------------------------------

* **asset**: Asset object included in the offering being created
* **product_offering**: JSON with the raw product offering information that has been validated. (The structure of this JSON object can be found in the Open Api documentation)

on_product_acquisition
----------------------

* **asset**: Asset object that has been acquired
* **contract**: Contract object including the information of the acquired offering which contains the asset. (The Contract object is described later)
* **order**: Order object including the information of the order where the asset was acquired. (The Order object is described later)

on_product_suspension
---------------------

* **asset**: Asset object that has been suspended
* **contract**: Contract object including the information of the acquired offering which contains the asset
* **order**: Order object including the information of the order where the asset was acquired

get_pending_accounting
----------------------

* **asset**: Asset object whose usage information has to be retrieved
* **contract**: Contract object including the information of the acquired offering which contains the asset
* **order**: Order object including the information of the order where the asset was acquired

Handler Objects
---------------

Following you can find the information regarding the different objects used in plugin handlers

* **User**: Django model object with the following fields
   * **username**: Username of the user
   * **email**: Email of the user
   * **complete_name**: Complete name of the user

* **Asset**: Django model object with the following fields
   * **product_id**: Id of the product specification which includes the asset
   * **version**: Version of the product specification which includes the asset
   * **provider**: User object of the user that created the asset
   * **content_type**: media type of the asset
   * **download_link**: URL of the asset if it is a service in an external server
   * **resource_path**: Path to the asset file if it is uploaded in the server
   * **resource_type**: Type of the asset as defined in the package.json file of the related plug-in
   * **is_public**: If true the asset can be downloaded by any user without the need of acquiring it
   * **meta_info**: JSON with any related information. This field is useful to include specific info from the plugin code

Additionally, it includes the following methods:

* **get_url**: Returns the URL where the asset can be accessed
* **get_uri**: Returns the url where the asset info can be accessed


* **Contract**: Django model with the following fields
   * **item_id**: Id of the order item which generated the current contract
   * **offering**: Offering object with the information of the offering acquired in the current contract (The offering object is described later)
   * **product_id**: Id of the inventory product created as a result if the acquisition of the specified offering
   * **pricing_model**: JSON with the pricing model that is used in the current contract for charging the customer who acquired the included offering
   * **last_charge**: Datetime object with the date and time of the last charge to the customer
   * **charges**: List of Charge objects contaning the info of the different times the customer has been charged in the context of the current contract
   * **correlation_number**: Next expected correlation number for usage documents. This field is only used when the pricing model is usage
   * **last_usage**: Datetime object with the date and time of the last usage document received. This field is only used when the pricing model is usage
   * **revenue_class**: Product class of the involved offering for revenue sharing
   * **terminated**: Specified whether the contract has been terminated (the customer has no longer access to the acquired asset)

* **Offering**: Django model with the following fields
   * **off_id**: Id of the product offering
   * **name**: Name of the offering
   * **version**: Version of the offering
   * **description**: Description of the offering
   * **asset**: Asset offered in the offering

* **Charge** Django model with the following fields
   * **date**: Datetime object with the date and time of the charge
   * **cost**: Total amount charged
   * **duty_free**: Amount charged without taxes
   * **currency**: Currency of the charge
   * **concept**: Concept of the charge (initial, renovation, usage)
   * **invoice**: Path to the PDF file containing the invoice of the charge

* **Order**: Django model with the following fields
   * **order_id**: Id of the product order
   * **customer**: User object of the customer of the order
   * **date**: Datetime object with the date and time of the order creation
   * **tax_address**: JSON with the billing address used by the customer in the order
   * **contracts**: List of Conctract objects, one for earch offering acquired in the order

Additionally, it includes the following methods:

* **get_item_contract**: Returns a contract given an item_id
* **get_product_contract**: Returns a contract given a product_id

Managing Plugins
================

Once the plugin has been packaged in a zip file, the Charging Backend of the Business API Ecosystem offers some management
command that can be used to manage the plugins.

When a new plugin is registered, The Business API Ecosystem automatically generates an id for the plugin that is used for
managing it. To register a new plugin the following command is used:

::

    python manage.py loadplugin TestPlugin.zip


It is also possible to list the existing plugins in order to retrieve the generated ids:

::

    python manage.py listplugins


To remove a plugin it is needed to provide the plugin id. This can be done using the following command:

::

    python manage.py removeplugin test-plugin
