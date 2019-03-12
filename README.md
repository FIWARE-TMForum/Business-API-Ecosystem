# Business API Ecosystem

[![](https://nexus.lab.fiware.org/repository/raw/public/badges/chapters/data-monetization.svg)](https://www.fiware.org/developers/catalogue/)
[![License badge](https://img.shields.io/github/license/FIWARE-TMForum/Business-API-Ecosystem.svg)](https://opensource.org/licenses/AGPL-3.0)
[![Docker](https://img.shields.io/docker/pulls/fiware/business-api-ecosystem.svg)](https://hub.docker.com/r/fiware/business-api-ecosystem)
[![](https://img.shields.io/badge/tag-fiware-orange.svg?logo=stackoverflow)](http://stackoverflow.com/questions/tagged/fiware)
[![Support](https://img.shields.io/badge/support-askbot-yellowgreen.svg)](https://ask.fiware.org)
<br>
[![Documentation badge](https://img.shields.io/readthedocs/business-api-ecosystem.svg)](https://business-api-ecosystem.rtfd.io)
![Status](https://nexus.lab.fiware.org/static/badges/statuses/business-api.svg)

The Business API Ecosystem provides sellers the means for managing, publishing,
and generating revenue of their products, apps, data, and services. The Business
API Ecosystem enables the monetization of different kind of assets (both digital
and physical) across the whole service life cycle, from offer creation through
to charging, accounting and revenue settlement and sharing.

This project is part of [FIWARE](https://www.fiware.org/). For more information
check the FIWARE Catalogue entry for
[Data Publication and Monetization](https://github.com/Fiware/catalogue/tree/master/data-publication).

 | :books: [Documentation](https://business-api-ecosystem.rtfd.io/)  | :mortar_board: [Academy](https://fiware-academy.readthedocs.io/en/latest/data-publication/business-api) | :whale: [Docker Hub](https://hub.docker.com/r/fiware/business-api-ecosystem) |  :dart: [Roadmap](https://github.com/FIWARE-TMForum/Business-API-Ecosystem/blob/master/roadmap.md)|
|---|---|---|---|

## Contents

-   [Background](#background)
    -   [Description](#description)
-   [Install](#install)
-   [Usage](#usage)
-   [API](#api)
-   [Testing](#testing)
-   [Advanced Topics](#advanced-topics)
-   [Quality Assurance](#quality-assurance)
-   [License](#license)

## Background

This is the main repository of the Business API Ecosystem. This project is part
of [FIWARE](https://www.fiware.org), and has been developed in collaboration
with the [TM Forum](https://www.tmforum.org/). Check also the
[FIWARE Catalogue entry for the Business API Ecosystem](https://catalogue.fiware.org/enablers/business-api-ecosystem-biz-ecosystem-ri)!

The Business API Ecosystem is not a single software repository, but it is
composed of different projects which work coordinate to provide the complete
functionality.

Concretely, the Business API Ecosystem is made of the following components:

-   Reference implementations of TM Forum APIs.

    -   [Catalog Management API](https://github.com/FIWARE-TMForum/DSPRODUCTCATALOG2)
    -   [Product Ordering Management API](https://github.com/FIWARE-TMForum/DSPRODUCTORDERING)
    -   [Product Inventory Management API](https://github.com/FIWARE-TMForum/DSPRODUCTINVENTORY)
    -   [Party Management API](https://github.com/FIWARE-TMForum/DSPARTYMANAGEMENT)
    -   [Customer Management API](https://github.com/FIWARE-TMForum/DSCUSTOMER)
    -   [Billing Management API](https://github.com/FIWARE-TMForum/DSBILLINGMANAGEMENT)
    -   [Usage Management API](https://github.com/FIWARE-TMForum/DSUSAGEMANAGEMENT)

-   Rating, Charging, and Billing backend.

    -   [Charging Backend](https://github.com/FIWARE-TMForum/business-ecosystem-charging-backend)

-   Revenue Settlement and Sharing System.

    -   [RSS](https://github.com/FIWARE-TMForum/business-ecosystem-rss)

-   Authentication, API Orchestrator, and Web portal.
    -   [Logic Proxy](https://github.com/FIWARE-TMForum/business-ecosystem-logic-proxy)

Any feedback is highly welcome, including bugs, typos or things you think should
be included but aren't. To provide feedback you can use the general
[GitHub issues](https://github.com/FIWARE-TMForum/Business-API-Ecosystem/issues/new),
or provide it directly to the components using the
[Charging Backend Issues](https://github.com/FIWARE-TMForum/business-ecosystem-charging-backend/issues/new),
[RSS Issues](https://github.com/FIWARE-TMForum/business-ecosystem-rss/issues/new),
or
[Logic Proxy Issues](https://github.com/FIWARE-TMForum/business-ecosystem-logic-proxy/issues/new).

### Description

The Business API Ecosystem is a joint component made up of the FIWARE Business
Framework and a set of APIs (and its reference implementations) provided by the
TMForum. This component allows the monetization of different kind of assets
(both digital and physical) during the whole service life cycle, from offering
creation to its charging, accounting and revenue settlement and sharing. The
Business API Ecosystem exposes its complete functionality through TMForum
standard APIs; concretely, it includes the catalog management, ordering
management, inventory management, usage management, billing, customer, and party
APIs.

## Install

The instructions to install the Business API Ecosystem can be found at the
[Installation Guide](http://business-api-ecosystem.readthedocs.io/en/latest/installation-administration-guide.html).
You can install the software in three different ways:

-   Using the provided scripts
-   Using a
    [Docker Container](https://hub.docker.com/r/fiware/business-api-ecosystem)
-   Manually

## Usage

The Business API Ecosystem API is build up using the APIs of the different
components each exposing its own resources.

### Catalog API

The Catalog API is available under /DSProductCatalog/api/ and its main resources
are:

-   Categories
-   Catalogs
-   Product Specifications
-   Product Offerings

### Ordering API

The Ordering API is available under /DSProductOrdering/api/ and its main
resources are:

-   Product Order

### Inventory API

The Inventory API is available under /DSProductInventory/api/ and its main
resources are:

-   Product

### Party API

The Party API is available under /DSPartyManagement/api/ and its main resources
are:

-   Individual
-   Organization

### Customer API

The Customer API is available under /DSCustomerManagement/api/ and its main
resources are:

-   Customer
-   Customer Account

### Billing API

The Billing API is available under /DSBillingManagement/api/ and its main
resources are:

-   Billing Account
-   Applied Billing Charge

### Usage API

The Usage API is available under /DSUsageManagement/api/ and its main resources
are:

-   Usage
-   Usage Specification

### RSS API

The RSS API is available under /DSRevenueSharing/rss/ and its main resources
are:

-   Revenue Sharing Model
-   Transaction
-   Revenue Sharing Report

## API

For further documentation, you can check the API Reference available at:

-   [Apiary](http://docs.fiwaretmfbizecosystem.apiary.io)
-   [Github Pages](https://fiware-tmforum.github.io/Business-API-Ecosystem/)

## Testing

### End-to-End tests

End-to-End tests are described in the
[Installation Guide](http://business-api-ecosystem.readthedocs.io/en/latest/installation-administration-guide.html#end-to-end-testing)

### Unit tests

The way of executing the unit tests is described in each of the components
repositories

## Advanced Topics

-   [User Guide](doc/user-guide.rst)
-   [Programmer Guide](doc/programmer-guide.rst)
-   [Installation & Administration Guide](doc/installation-administration-guide.rst)

You can also find this documentation on
[ReadTheDocs](http://business-api-ecosystem.readthedocs.io)

## Quality Assurance

This project is part of [FIWARE](https://fiware.org/) and has been rated as
follows:

-   **Version Tested:**
    ![ ](https://img.shields.io/badge/dynamic/json.svg?label=Version&url=https://fiware.github.io/catalogue/json/biz_framework.json&query=$.version&colorB=blue)
-   **Documentation:**
    ![ ](https://img.shields.io/badge/dynamic/json.svg?label=Completeness&url=https://fiware.github.io/catalogue/json/biz_framework.json&query=$.docCompleteness&colorB=blue)
    ![ ](https://img.shields.io/badge/dynamic/json.svg?label=Usability&url=https://fiware.github.io/catalogue/json/biz_framework.json&query=$.docSoundness&colorB=blue)
-   **Responsiveness:**
    ![ ](https://img.shields.io/badge/dynamic/json.svg?label=Time%20to%20Respond&url=https://fiware.github.io/catalogue/json/biz_framework.json&query=$.timeToCharge&colorB=blue)
    ![ ](https://img.shields.io/badge/dynamic/json.svg?label=Time%20to%20Fix&url=https://fiware.github.io/catalogue/json/biz_framework.json&query=$.timeToFix&colorB=blue)
-   **FIWARE Testing:**
    ![ ](https://img.shields.io/badge/dynamic/json.svg?label=Tests%20Passed&url=https://fiware.github.io/catalogue/json/biz_framework.json&query=$.failureRate&colorB=blue)
    ![ ](https://img.shields.io/badge/dynamic/json.svg?label=Scalability&url=https://fiware.github.io/catalogue/json/biz_framework.json&query=$.scalability&colorB=blue)
    ![ ](https://img.shields.io/badge/dynamic/json.svg?label=Performance&url=https://fiware.github.io/catalogue/json/biz_framework.json&query=$.performance&colorB=blue)
    ![ ](https://img.shields.io/badge/dynamic/json.svg?label=Stability&url=https://fiware.github.io/catalogue/json/biz_framework.json&query=$.stability&colorB=blue)

---

## License

Business-API-Ecosystem is licensed under [Affero General Public License (GPL)
version 3](./LICENSE).

### Are there any legal issues with AGPL 3.0? Is it safe for me to use?

There is absolutely no problem in using a product licensed under AGPL 3.0. Issues with GPL 
(or AGPL) licenses are mostly related with the fact that different people assign different 
interpretations on the meaning of the term “derivate work” used in these licenses. Due to this,
some people believe that there is a risk in just _using_ software under GPL or AGPL licenses
(even without _modifying_ it).

For the avoidance of doubt, the owners of this software licensed under an AGPL 3.0 license  
wish to make a clarifying public statement as follows:

> Please note that software derived as a result of modifying the source code of this
> software in order to fix a bug or incorporate enhancements is considered a derivative 
> work of the product. Software that merely uses or aggregates (i.e. links to) an otherwise 
> unmodified version of existing software is not considered a derivative work, and therefore
> it does not need to be released as under the same license, or even released as open source.
