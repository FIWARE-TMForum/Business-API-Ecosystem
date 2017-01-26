=============
Plugins Guide
=============

------------
Introduction
------------

This plugins guide covers the available plugins (defining digital asset types) for the Business API Ecosystem v5.4.1.
Any feedback on this document is highly welcomed, including bugs, typos or things you think should be included but aren't.
Please send them to the "Contact Person" email that appears in the `Catalogue page for this GEi`_. Or create an issue at `GitHub Issues`_

.. _Catalogue page for this GEi: https://catalogue.fiware.org/enablers/business-api-ecosystem-biz-ecosystem-ri
.. _GitHub Issues: https://github.com/FIWARE-TMForum/Business-API-Ecosystem/issues/new

-------------------
WireCloud Component
-------------------

The *WireCloud Component* plugin is available in `GitHub <https://github.com/FIWARE-TMForum/wstore-wirecloud-plugin>`__.
This plugin defines an asset type intended to manage and monetize the different WireCloud components (Widgets, Operators,
and Mashups) in  particular by enabling the creation of product specifications providing the WGT file of the specific
component. (For more details on the WireCloud platform see its documentation in `ReadTheDocs <https://wirecloud.readthedocs.io>`__)

The WireCloud component plugin allows to provide the WGT file in the two ways supported by the Business API Ecosystem,
that is, uploading the WGT file when creating the product and providing a URL where the platform can download the file.

In addition, the plugin only allows the media type *Mashable application component*. Nevertheless, the plugin code uses the WGT
metainfo to determine the type of the WireCloud component (Widget, Operator, or Mashup) and overrides the media type with the
proper one understood by the WireCloud platform (*wirecloud/widget*, *wirecloud/operator* or *wirecloud/mashup*).

.. image:: /images/plugin/wirecloud1.png
   :align: center

.. image:: /images/plugin/wirecloud2.png
   :align: center

This plugin implements the following event handlers:

* **on_post_product_spec_validation**: In this handler the plugin validates the WGT file to ensure that it is a valid WireCloud Component
* **on_post_product_spec_attachment**: In this handler the plugin determines the media type of the WGT file and overrides the media type value in the specific product specification


------------
CKAN Dataset
------------

The *CKAN Dataset* plugin ia available in `GitHub <https://github.com/FIWARE-TMForum/wstore-ckan-plugin>`__.
This plugin defines an asset type intended to manage and monetize datasets offered in a CKAN instance. In particular,
this plugin is able to validate the dataset, validate the rights of the seller creating a product specification to sell
the provided dataset, and manage the access to the dataset of those customers who acquire it.

Is important to notice that by default CKAN does not provide a mechanism to publish protected datasets or an API for
managing the access rights to the published datasets. In this regard, the CKAN instance to be monetized has to be extended
with the following CKAN plugins:

* `ckanext-oauth2 <https://github.com/conwetlab/ckanext-oauth2>`__: This extension allows to use an external OAuth2 Identity Manager
  for managing CKAN users. In particular, this extension must be used, in this context, to authenticate users using the same
  FIWARE IdM instance as the specific Business API Ecosystem instance, so both systems (CKAN and Business API Ecosystem)
  share their users.
* `ckanext-privatedatasets <https://github.com/conwetlab/ckanext-privatedatasets>`__: This extension allows to create
  protected datasets in CKAN which can only be accessed by a set of users selected by the dataset owner. Moreover, this
  extension exposes an API that can be used to add or remove authorized users from a dataset.

In addition, if the `ckanext-storepublisher <https://github.com/FIWARE-TMForum/ckanext-storepublisher>`__ plugin is installed
in CKAN, the *CKAN dataset* plugin must be installed in the Business API Ecosystem, since the aforementioned CKAN extension
uses the *CKAN Dataset* asset type for creating product specifications.

The CKAN Dataset plugin only allows to provide the asset with a URL that must match the dataset URL in CKAN.

.. image:: /images/plugin/ckan1.png
   :align: center

This plugin implements the following event handlers:

* **on_pre_product_spec_validation**: In this handler the plugin validates that the provided URL is a valid CKAN dataset and
  that the user creating the product specification is its owner.
* **on_product_acquisition**: In this handler the plugin uses the CKAN instance API in order to grant access to the user
  who has acquired a dataset.
* **on_product_suspension**: In this handler the plugin uses the CKAN instance API in order to revoke access to a dataset
  when a user has not paid or when the user cancels a subscription.


-------------------
Accountable Service
-------------------

The *Accountable Service* plugin is available in `GitHub <https://github.com/FIWARE-TMForum/wstore-orion-plugin>`__.
This plugin defines a generic asset type which is used jointly with the `Accounting Proxy <https://github.com/FIWARE-TMForum/Accounting-Proxy>`__
in order to offer services under a pay-per-use model. In particular, this plugin is able to validate services URLs,
validate sellers permissions, generate API keys for the Accounting Proxy, validate offering pricing models, and manage
customers access rights to the offered services.

Taking into account that this plugin is intended tyo work coordinately with an instance of the Accounting Proxy, all
the assets to be registered using the *Accountable Service* type must be registered in the proxy as described in the
Accounting Proxy section.

The *Accountable Service* plugin only allows to provide the assets with a URL that must match the service one.

.. image:: /images/plugin/accounting1.png
   :align: center

This plugin implements the following event handlers:

* **on_post_product_spec_validation**: In this event handler the plugin validates that the provided URL belongs to a valid
  service registered in an instance of the Accounting Proxy, and that the user creating the product specification is its owner.
  In addition, this handler generates an API key for the Accounting Proxy to be used when it feeds the Business API Ecosystem
  with accounting information.
* **on_post_product_offering_validation**: In this event handler the plugin validates the pricing model of a product offering
  where the service is going to be sold. Specifically, it validates that all the price plans which can be selected by a
  customer are usage models and that the units (calls, seconds, mb, etc) are supported by the Accounting Proxy.
* **on_product_acquisition**: This event handler is used to grant access to a user who has acquired a service by sending
  a notification to the proxy, including also the unit to be accounted (price plan selected).
* **on_product_suspension**: This event handler is used to in order to revoke access to a service when a user has not
  paid or when the user cancels a subscription.

Accounting Proxy
================
