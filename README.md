# Business-API-Ecosystem

[![](https://img.shields.io/badge/FIWARE-Data_Monetization-51b6a3.svg?label=FIWARE&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABsAAAAVCAYAAAC33pUlAAAABHNCSVQICAgIfAhkiAAAA8NJREFUSEuVlUtIFlEUx+eO+j3Uz8wSLLJ3pBiBUljRu1WLCAKXbXpQEUFERSQF0aKVFAUVrSJalNXGgmphFEhQiZEIPQwKLbEUK7VvZrRvbr8zzjfNl4/swplz7rn/8z/33HtmRhn/MWzbXmloHVeG0a+VSmAXorXS+oehVD9+0zDN9mgk8n0sWtYnHo5tT9daH4BsM+THQC8naK02jCZ83/HlKaVSzBey1sm8BP9nnUpdjOfl/Qyzj5ust6cnO5FItJLoJqB6yJ4QuNcjVOohegpihshS4F6S7DTVVlNtFFxzNBa7kcaEwUGcbVnH8xOJD67WG9n1NILuKtOsQG9FngOc+lciic1iQ8uQGhJ1kVAKKXUs60RoQ5km93IfaREvuoFj7PZsy9rGXE9G/NhBsDOJ63Acp1J82eFU7OIVO1OxWGwpSU5hb0GqfMydMHYSdiMVnncNY5Vy3VbwRUEydvEaRxmAOSSqJMlJISTxS9YWTYLcg3B253xsPkc5lXk3XLlwrPLuDPKDqDIutzYaj3eweMkPeCCahO3+fEIF8SfLtg/5oI3Mh0ylKM4YRBaYzuBgPuRnBYD3mmhA1X5Aka8NKl4nNz7BaKTzSgsLCzWbvyo4eK9r15WwLKRAmmCXXDoA1kaG2F4jWFbgkxUnlcrB/xj5iHxFPiBN4JekY4nZ6ccOiQ87hgwhe+TOdogT1nfpgEDTvYAucIwHxBfNyhpGrR+F8x00WD33VCNTOr/Wd+9C51Ben7S0ZJUq3qZJ2OkZz+cL87ZfWuePlwRcHZjeUMxFwTrJZAJfSvyWZc1VgORTY8rBcubetdiOk+CO+jPOcCRTF+oZ0okUIyuQeSNL/lPrulg8flhmJHmE2gBpE9xrJNkwpN4rQIIyujGoELCQz8ggG38iGzjKkXufJ2Klun1iu65bnJub2yut3xbEK3UvsDEInCmvA6YjMeE1bCn8F9JBe1eAnS2JksmkIlEDfi8R46kkEkMWdqOv+AvS9rcp2bvk8OAESvgox7h4aWNMLd32jSMLvuwDAwORSE7Oe3ZRKrFwvYGrPOBJ2nZ20Op/mqKNzgraOTPt6Bnx5citUINIczX/jUw3xGL2+ia8KAvsvp0ePoL5hXkXO5YvQYSFAiqcJX8E/gyX8QUvv8eh9XUq3h7mE9tLJoNKqnhHXmCO+dtJ4ybSkH1jc9XRaHTMz1tATBe2UEkeAdKu/zWIkUbZxD+veLxEQhhUFmbnvOezsJrk+zmqMo6vIL2OXzPvQ8v7dgtpoQnkF/LP8Ruu9zXdJHg4igAAAABJRU5ErkJgggA=)](https://www.fiware.org/developers/catalogue/)
[![License badge](https://img.shields.io/github/license/FIWARE-TMForum/Business-API-Ecosystem.svg)](https://opensource.org/licenses/AGPL-3.0) 
[![Documentation badge](https://img.shields.io/readthedocs/business-api-ecosystem.svg)](https://business-api-ecosystem.rtfd.io) 
[![Docker](https://img.shields.io/docker/pulls/fiware/business-api-ecosystem.svg)](https://hub.docker.com/r/fiware/business-api-ecosystem)  
[![](https://img.shields.io/badge/tag-fiware-orange.svg?logo=stackoverflow)](http://stackoverflow.com/questions/tagged/fiware) 
[![Support](https://img.shields.io/badge/support-askbot-yellowgreen.svg)](https://ask.fiware.org)

 * [Introduction](#introduction)
 * [GEi Overall Description](#gei-overall-description)
 * [Installation](#build-and-install)
 * [API Overview](#api-overview)
 * [API Reference](#api-reference)
 * [Testing](#testing)
 * [Advanced Topics](#advanced-topics)

# Introducction

This is the main repository of the Business API Ecosystem. This project is part of [FIWARE](https://www.fiware.org), and has been developed in 
collaboration with the [TM Forum](https://www.tmforum.org/). Check also the [FIWARE Catalogue entry for the Business API Ecosystem](https://catalogue.fiware.org/enablers/business-api-ecosystem-biz-ecosystem-ri)!

The Business API Ecosystem is not a single software repository, but it is composed of different projects which work coordinatelly to provide the complete functionality.

Concretely, the Business API Ecosystem is made of the following components:

* Reference implementations of TM Forum APIs.
    * [Catalog Management API](https://github.com/FIWARE-TMForum/DSPRODUCTCATALOG2)
    * [Product Ordering Management API](https://github.com/FIWARE-TMForum/DSPRODUCTORDERING)
    * [Product Inventory Management API](https://github.com/FIWARE-TMForum/DSPRODUCTINVENTORY)
    * [Party Management API](https://github.com/FIWARE-TMForum/DSPARTYMANAGEMENT)
    * [Customer Management API](https://github.com/FIWARE-TMForum/DSCUSTOMER)
    * [Billing Management API](https://github.com/FIWARE-TMForum/DSBILLINGMANAGEMENT)
    * [Usage Management API](https://github.com/FIWARE-TMForum/DSUSAGEMANAGEMENT)

* Rating, Charging, and Billing backend.
    * [Charging Backend](https://github.com/FIWARE-TMForum/business-ecosystem-charging-backend)

* Revenue Settlement and Sharing System.
    * [RSS](https://github.com/FIWARE-TMForum/business-ecosystem-rss)

* Authentication, API Orchestrator, and Web portal.
    * [Logic Proxy](https://github.com/FIWARE-TMForum/business-ecosystem-logic-proxy)

Any feedback is highly welcome, including bugs, typos or things you think should be included but aren't. To provide feedback you can use the 
general [GitHub issues](https://github.com/FIWARE-TMForum/Business-API-Ecosystem/issues/new), or provide it directly to the components using the [Charging Backend Issues](https://github.com/FIWARE-TMForum/business-ecosystem-charging-backend/issues/new), [RSS Issues](https://github.com/FIWARE-TMForum/business-ecosystem-rss/issues/new), or [Logic Proxy Issues](https://github.com/FIWARE-TMForum/business-ecosystem-logic-proxy/issues/new).

# GEi Overall Description

The Business API Ecosystem is a joint component made up of the FIWARE Business Framework and a set of APIs (and its reference implementations) provided by the TMForum. This component allows the monetization of different kind of assets (both digital and physical) during the whole service life cycle, from offering creation to its charging, accounting and revenue settlement and sharing. The Business API Ecosystem exposes its complete functionality through TMForum standard APIs; concretely, it includes the catalog management, ordering management, inventory management, usage management, billing, customer, and party APIs.

# Installation

The instructions to install the Business API Ecosystem can be found at the [Installation Guide](http://business-api-ecosystem.readthedocs.io/en/latest/installation-administration-guide.html). You can install the software in three different ways:

* Using the provided scripts
* Using a [Docker Container](https://hub.docker.com/r/fiware/business-api-ecosystem)
* Manually

# API Overview

The Business API Ecosystem API is build up using the APIs of the different components each exposing its own resources.

## Catalog API

The Catalog API is available under /DSProductCatalog/api/ and its main resources are:

* Categories
* Catalogs
* Product Specifications
* Product Offerings

## Ordering API

The Ordering API is available under /DSProductOrdering/api/ and its main resources are:

* Product Order

## Inventory API

The Inventory API is available under /DSProductInventory/api/ and its main resources are:

* Product

## Party API

The Party API is available under /DSPartyManagement/api/ and its main resources are:

* Individual
* Organization

## Customer API

The Customer API is available under /DSCustomerManagement/api/ and its main resources are:

* Customer
* Customer Account

## Billing API

The Billing API is available under /DSBillingManagement/api/ and its main resources are:

* Billing Account
* Applied Billing Charge

## Usage API

The Usage API is available under /DSUsageManagement/api/ and its main resources are:

* Usage
* Usage Specification

## RSS API

The RSS API is available under /DSRevenueSharing/rss/ and its main resources are:

* Revenue Sharing Model
* Transaction
* Revenue Sharing Report

# API Reference

For further documentation, you can check the API Reference available at:

* [Apiary](http://docs.fiwaretmfbizecosystem.apiary.io) 
* [Github Pages](https://fiware-tmforum.github.io/Business-API-Ecosystem/)

# Testing

## End-to-End tests

End-to-End tests are described in the [Installation Guide](http://business-api-ecosystem.readthedocs.io/en/latest/installation-administration-guide.html#end-to-end-testing)

## Unit tests

The way of executing the unit tests is described in each of the components repositories

# Advanced Topics

* [User Guide](doc/user-guide.rst)
* [Programmer Guide](doc/programmer-guide.rst)
* [Installation & Administration Guide](doc/installation-administration-guide.rst)

You can also find this documentation on [ReadTheDocs](http://business-api-ecosystem.readthedocs.io)
