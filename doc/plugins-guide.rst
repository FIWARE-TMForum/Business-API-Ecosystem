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

In addition, the plugin only allows the media type *WireCloud Component*. Nevertheless, the plugin code uses the WGT
metainfo to determine the type of the WireCloud component (Widget, Operator, or Mashup) and overrides the media type with the
proper one understood by the WireCloud platform (*wirecloud/widget*, *wirecloud/operator* or *wirecloud/mashup*).

.. image:: /images/user/wirecloud1.png
   :align: center

.. image:: /images/user/wirecloud2.png
   :align: center

This plugin implements the following event handlers:

* **on_post_product_spec_validation**: In this handler the plugin validates the WGT file to ensure that it is a valid WireCloud Component
* **on_post_product_spec_attachment**: In this handler the plugin determines the media type of the WGT file and overrides the media type value in the specific product specification


------------
CKAN Dataset
------------

-------------------
Accountable Service
-------------------

Accounting Proxy
================
