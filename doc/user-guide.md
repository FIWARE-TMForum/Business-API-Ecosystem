# User Guide

This user guide contains a description of the different tasks that can be performed in the Business API Ecosystem using
its web interface. This section is organized so the actions related to a particular user role are grouped together.

(admin)=
(manage-categories)=
(manage-idps)=
Marketplace administration is covered separately in the [Administrator Guide](admin-guide.md).

## Using Organizations

The Business API Ecosystem supports organizations as defined by the FIWARE IdM. These organizations
can use the system as if they were users, being possible to create organizations catalogs and offerings or acquire them.

To use the platform on behalf an organization the user belongs, it is needed to change the platform context. To do that,
it is used the *Switch Session* option of the user menu.

![](./images/user/org.png)

## Profile Configuration

All the users of the system can configure their profile, so they can configure their personal information as well as their
billing addresses and contact mediums.

To configure the user profile, the first step is opening the user *Settings* located in the user menu.

![](./images/user/profile1.png)

In the displayed view, it can be seen that some information related to the account is already included (*Username*, *Email*, *Access token*).
This information is the one provided by the IdM after the login process.

The profile to be updated depends on whether the user is acting on behalf an organization or himself. In both cases, to
update the profile, fill in the required information and click on *Update*.

For users, personal information is provided.

![](./images/user/profile2.png)

> **Note:** Only the *First name* and *Last name* fields are mandatory.

For organizations, general organization info is provided.

![](./images/user/profileOrg.png)

Once you have created your profile, you can include contact mediums by going to the *Contact mediums* section.

![](./images/user/profile3.png)

In the *Contact Medium* section, there are two different tabs. On the one hand, the *Shipping addresses* tab, where you
can register the shipping addresses you will be able to use when creating orders and purchasing products.

To create a shipping address, fill in the fields and click on *Create*:

![](./images/user/profile4.png)

Once created, you can edit the address by clicking on the *Edit* button of the specific address, and changing the
wanted fields.

![](./images/user/profile5.png)

![](./images/user/profile6.png)

On the other hand, if you have the *Seller* role you can create *Business Addresses*, which can be used by your customers
in order to allow them to contact you.

![](./images/user/profile7.png)

In the *Business Addresses* tab you can create different kind of contact mediums, including emails, phones, and addresses.
To create a contact medium, fill in the fields and click on *Create*:

![](./images/user/profile8.png)

![](./images/user/profile9.png)

![](./images/user/profile10.png)

You can *Edit* or *Remove* the contact medium by clicking on the corresponding button:

![](./images/user/profile11.png)

## Seller

If the user of the Business API Ecosystem has the *Seller* role, he will be able to monetize his products by creating,
catalogs, product specifications and product offerings. All these objects are managed accessing *My Stock* section.

![](./images/user/catalog1.png)

### Manage Catalogs

The *Catalogs* section is the one that is open by default when the seller accesses *My Stock* section. This section
contains the catalogs the seller has created.

![](./images/user/catalog2.png)

Additionally, it has been defined several mechanisms for searching and filtering the list of catalogs displayed. On the one
hand, it is possible to search catalogs by keyword using the search input provided in the menu bar. On the other hand,
it is possible to specify how catalog list should be sorted or filter the shown catalogs by status and the role you are
playing. To do that, click on *Filters*, choose the required parameters, and click on *Close*.

![](./images/user/catalog8.png)

![](./images/user/catalog9.png)

To create a new catalog click on the *New* button.

![](./images/user/catalog3.png)

Then, provide a name and an optional description for the catalog. Once you have filled the fields, click on *Next*, and then on *Create*:

![](./images/user/catalog4.png)

![](./images/user/catalog5.png)

Sellers can also update their catalogs. To do that, click on the name of the catalog to open the update view.

![](./images/user/catalog6.png)

Then, update the fields you want to modify and click on *Update*. In this view, it is possible to change the *Status* of the
catalog. To start monetizing the catalog, and make it appear in the *Home* you have to change its status to *Launched*:

![](./images/user/catalog7.png)

### Manage Product Specifications

Product Specifications represent the product being offered, both digital and physical. To list your product specifications
go to *My Stock* section and click on *Product Specifications*:

![](./images/user/product1.png)

In the same way as catalogs, product specifications can be searched by keyword, sorted, or filtered by status and whether
they are bundles or not. To filter or sort product specifications, click on *Filters*, choose the appropriate properties, and click on *Close*:

![](./images/user/product2.png)

![](./images/user/product3.png)

Additionally, it is possible to switch between the grid view and the tabular view using the provided buttons.

![](./images/user/product4.png)

![](./images/user/product5.png)

To create a new product specification click on *New*:

![](./images/user/product6.png)

In the displayed view, provide the general information of the product spec. including its name, version, and an optional
description. In addition, you have to include the product brand (Your brand), and an ID number which identifies the product
in your environment. Then, click on *Next*.

![](./images/user/product7.png)

In the next step, you can choose whether your product specification is a bundle or not. Product bundles are logical containers
that allow you to sell multiple products as if it were a single one. Once you have selected the right option click on *Next*:

![](./images/user/product8.png)

If you have decided to create a bundle, you will be required to choose 2 or more product specs to be included in the bundle.

![](./images/user/product9.png)

In the next step you can choose if your product is a digital product. If this is the case, you will be required to provide
the asset.

> **Note:** If you are creating a product bundle, you will not be allowed to provide a digital asset since the offered ones will be included in the bundled products.

For providing the asset, you have to choose between the available asset types, choose how to provide the asset between the
available options, provide the asset, and include its media type.

![](./images/user/product10.png)

![](./images/user/product11.png)

The next step in the creation of a product is including its characteristics. For including a new characteristic click on
*New Characteristic*:

![](./images/user/product12.png)

In the form, include the name, the type (string or number) and an optional description. Then create the values of the
characteristic by filling the *Create a value* input and clicking on *+*.

![](./images/user/product13.png)

Once you have included all the characteristic info, save it clicking on *Create*:

![](./images/user/product14.png)

Once you have included all the required characteristics click on *Next*:

![](./images/user/product15.png)

In the next step you can include a picture for your product spec. You have two options, providing an URL pointing to the
picture or directly uploading it. In addition, it is possible to include multiple file attachments
to the product spec, such as images, PDF documentation, etc. Once provided click *Next*:

![](./images/user/product16.png)

![](./images/user/product17.png)

In the last step, you can specify relationships of the product you are creating with other of your product specs.

![](./images/user/product18.png)

Once done click on *Next* and then on *Create*:

![](./images/user/product19.png)

Sellers can update their products. To do that click on the product specification to be updated.

![](./images/user/product20.png)

Update the required values and click on *Update*. Note that for start selling an offering that includes the product specification
you will be required to change its status to *Launched*:

![](./images/user/product21.png)

> **Note:** For digital products it is not allowed to update the version using this form. Instead it is required to follow the process for upgrading the product version.

The basic information of the product specification is not the only information that can be updated, but it is also possible
to update the *Attachments* and the *Relationships* by clicking of the related tab.

![](./images/user/product22.png)

![](./images/user/product23.png)

The displayed details form can be used for digital products specifications in order to provide new versions of the digital assets
being offered. This can be done by clicking on *Upgrade*.

![](./images/user/product24.png)

In the displayed form, it is required to include a new version for the product specification and to provide the new digital
asset to be offered.

![](./images/user/product25.png)

> **Note:** All the customers who have acquired an offering including the current product specification will be able to access to the new version of the digital asset.

### Manage Product Offerings

Product Offerings are the entities that contain the pricing models and revenue sharing info used to monetize a product specification.
To list your product offerings, go to *My Stock* section and click on *Offerings*:

![](./images/user/offering1.png)

The existing product offerings can be searched by keyword, sorted, or filtered by status and whether they are bundles or not.
To filter or sort product offerings, click on *Filters*, choose the appropriate properties, and click on *Close*:

![](./images/user/offering2.png)

![](./images/user/offering3.png)

Additionally, it is possible to switch between the grid view and the tabular view by clicking on the specific button.

![](./images/user/offering4.png)

![](./images/user/offering5.png)

To create a new offering click on *New*:

![](./images/user/offering6.png)

In the displayed form, include the basic info of the offering. Including, its name, version, an optional description, and
an optional set of places where the offering is available. Once the information has been provided click on *Next*:

![](./images/user/offering7.png)

In the next step, you can choose whether your offering is a bundle or not. In this case, offering bundles are logical
containers that allow you to provide new pricing models when a set of offerings are acquired together. Once selected click
on *Next*:

![](./images/user/offering8.png)

If you want to create a bundle you will be required to include at least two bundled offerings.

![](./images/user/offering9.png)

In the next step you have to select the product specification that is going to be monetized in the current offering. Once
selected click on *Next*.

![](./images/user/offering10.png)

> **Note:** If you are creating an offering bundle, you will not be allowed to include a product specification.

Then, you have to select the catalog where you want to publish your offering and click on *Next*:

![](./images/user/offering11.png)

In the next step, you can optionally choose categories for your offering. Once done, click on *Next*:

![](./images/user/offering12.png)

Next, it is possible to include the License or terms and conditions to be applied to the offering being created.
There are three different options for providing such information: (1) For data, there is a set of standard open data
licenses that can be chosen, (2) providing custom terms and conditions using a wizard, and (3) providing terms and
conditions providing free text.

![](./images/user/offering12b.png)

![](./images/user/offering12c.png)

![](./images/user/offering12d.png)

It is possible to include some SLA information attached to the offering in the step of the form. To do that, click
on *Define new metric* button. In the displayed form, choose a metric, provide its value and click on *Add metric*.

![](./images/user/offering12e.png)

Once all the metrics have been provided click on *Next*:

![](./images/user/offering12f.png)

The next step is the most important for the offering. In the displayed form you can create different price plans for
your offering, which will be selectable by customers when acquiring the offering. If you do not include any price plan
the offering is considered free.

To include a new price plan the first step is clicking on *New Price Plan*:

![](./images/user/offering13.png)

For creating the price plan, you have to provide a name, and an optional description. Then, you have to choose the type
of price plan between the provided options.

The available types are: *one time* for payments that are made once when purchasing the offering, *recurring* for charges
that are made periodically (e.g a monthly payment), and *usage* for charges that are calculated applying the pricing model
to the actual usage made of the acquired service.

If you choose *one time*, you have to provide the price and the currency.

![](./images/user/offering14.png)

If you choose *recurring*, you have to provide the price, the currency, and the period between charges.

![](./images/user/offering15.png)

If you choose usage, you have to provide the unit to be accounted, the currency, and the price per unit:

![](./images/user/offering16.png)

In addition to the basic pricing models it is possible to include price alterations using the *Price Alteration*
section. In this regard, it is possible to provide two types of alterations: (1) Price components, enable to extend
the model with a complementary pricing (e.g an initial or recurring fixed payment in a usage model). (2) fees and discounts,
which are applied to the original model when some condition is satisfied (e.g a 2% discount when more that 10k calls has been made).

![](./images/user/offering16b.png)

![](./images/user/offering16c.png)

You can update or remove plans by clicking on the corresponding action button.

![](./images/user/offering17.png)

Once you have created your pricing model click on *Next*:

![](./images/user/offering18.png)

In the last step of the process, you have to choose the revenue sharing model to be applied to your offering between the
available ones. Once done, click on *Next* and then on *Create*.

![](./images/user/offering19.png)

![](./images/user/offering20.png)

Sellers can also edit their offerings. To do that click on the offering to be updated.

![](./images/user/offering21.png)

In the displayed form, change the fields you want to edit and click on *Update*. Note that for start selling your offering
you have to update its status to *Launched*:

![](./images/user/offering22.png)

It is also possible to update the *Price Plans* and *Categories* of the offering by accessing to the related tab.

![](./images/user/offering23.png)

![](./images/user/offering24.png)

### Manage Revenue Sharing Models

Revenue Sharing Models specify how the revenues generated by an offering or set of offerings must be distributed between
the owner of the Business API Ecosystem instance, the provider of the offering, and the related stakeholders involved.

To manage RS models go to the *Revenue Sharing* section.

![](./images/user/revenue1.png)

In this view, you can see the revenue sharing models you have available. By default it will appear the default RS model
which establishes the revenue distribution between you and the Business API Ecosystem instance owner.

![](./images/user/revenue2.png)

You can create a new RS model clicking on *New*:

![](./images/user/revenue3.png)

In the first step of the process you have to provide a product class, which identifies the RS model, and the percentage
you want to receive. The platform percentage is fixed and cannot be modified. Once provided click on *Next*:

![](./images/user/revenue4.png)

In the next step, you can optionally add more stakeholders to the RS model. To do that click on *New Stakeholder*:

![](./images/user/revenue5.png)

Then, select the Stakeholder between the available users, and provide its percentage. Finally, save it clicking on *Create*:

![](./images/user/revenue6.png)

> **Note:** The total percentage (provider + platform + stakeholders) must be equal to 100.

Finally, click on *Next* and then on *Create*:

![](./images/user/revenue7.png)

![](./images/user/revenue8.png)

Sellers can also update their RS model. To do that click on the RS model to be updated.

![](./images/user/revenue9.png)

Then, update the required fields (including the stakeholders if you want), and click on *Save Changes*:

![](./images/user/revenue10.png)

### Manage Transactions

Sellers can manage the transactions related to their products in order to know how much money their products are generating,
and to launch the revenue sharing process. To manage your seller transactions go to *Revenue Sharing* and click on *Transactions*:

![](./images/user/tran1.png)

In the displayed view, you can see the transactions pending to be paid to you and your stakeholders. It is also possible
to display the transactions in tabular way:

![](./images/user/tran2.png)

![](./images/user/tran3.png)

These transactions are aggregated and paid by the Business API Ecosystem periodically once a month. Nevertheless, if you
need to be paid, you can force the revenue sharing calculation and payment of your pending transactions by manually generating
a revenue sharing report.

To create a new report click on *New Report*:

![](./images/user/tran4.png)

In the displayed modal, choose the product classes to be calculated and click on *Create*:

![](./images/user/tran5.png)

This process will aggregate all the transactions with the selected product classes, calculate the amount to be paid to
each stakeholder using the related revenue sharing model, generate a revenue sharing report,
and pay the seller and the stakeholders using their PayPal account.

You can see the generated reports clicking on *RS Reports*:

![](./images/user/tran6.png)

![](./images/user/tran7.png)

> **Note:** Sellers would need to have a PayPal account associated to the email of their FIWARE IdM account in order to be paid for their products.

### Manage Received Orders

Sellers can manage the orders they have received in order to see the chosen characteristics, read customer notes, or
process the order in case it has been acquired a physical product.

To view your received orders go to *My inventory* section, click on *Product orders*, and open the *Received* section.

![](./images/user/provord1.png)

![](./images/user/provord2.png)

![](./images/user/provord3.png)

You can view the details of a received order clicking on the order date:

![](./images/user/provord4.png)

In the displayed view you can review the details of the order and the details of your products acquired by the customer,
including the chosen characteristics.

Additionally, you can view the customer notes clicking on the *Notes* tab:

![](./images/user/provord5.png)

You can also give a reply to customer notes including it in the text area and clicking on the send button:

![](./images/user/provord6.png)

If the acquired product is not digital, the order needs to be processed manually by the seller, in the sense that the
seller will have to send the acquired product to the customer. To deal with this situation, the order details view allows
sellers to manually change the status of the order.

To reject a received order you have to click in the *Reject* button located in the search or in the details view of the order.

![](./images/user/provord7.png)

![](./images/user/provord8.png)

In case you accept the order and send the product to the customer, you have to put it as *inProgress* clicking on the *Sent* button:

![](./images/user/provord9.png)

![](./images/user/provord10.png)

Finally, when the product arrives at its destination, you have to put it as *Completed* clicking on the *Delivered* button:

![](./images/user/provord11.png)

![](./images/user/provord12.png)

## Customer

All of the users of the system have by default the *Customer* role. Customers are able to create orders for acquiring
offerings.

### List Available Offerings

All the available (*Launched*) offerings appear in the *Home* page of the Business API Ecosystem, so they can be seen by
customers.

![](./images/user/search1.png)

Additionally, customers can select a specific catalog of offerings by clicking on it.

![](./images/user/search2.png)

![](./images/user/search3.png)

Moreover, customers can filter the shown offerings by category using the categories dropdown and choosing the wanted one.

![](./images/user/search4.png)

Customers can also filter bundle or single offerings using the *Filters* modal as well as choosing its sorting.

![](./images/user/search5.png)

![](./images/user/search6.png)

Finally, customers can search offerings by keyword using the provided search bar:

![](./images/user/search6b.png)

Customers can open the details of an offering by clicking on it:

![](./images/user/search7.png)

In the displayed view, it is shown the general info about the offering and its included product, the characteristics of
the product, the price plans of the offering, and the existing relationships.

![](./images/user/search8.png)

![](./images/user/search9.png)

![](./images/user/search10.png)

### Create Order

Customers can create orders for acquiring offerings. The different offerings to be included in an order are managed using
the *Shopping Cart*.

To include an offering in the shopping cart there are two possibilities. You can click on the *Add to Cart* button located
in the offering panel when searching, or you can click on the *Add to Cart* button located in the offering details view.

![](./images/user/order1.png)

![](./images/user/order2.png)

If the offering has configurable characteristics, multiple price plans or terms and conditions, a modal will be displayed where you can select
your preferred options:

![](./images/user/order3.png)

![](./images/user/order4.png)

![](./images/user/order4b.png)

Once you have selected your preferences for the offering click on *Add to Cart*:

![](./images/user/order5.png)

Once you have included all the offerings you want to acquire to the shopping cart, you can create the order clicking on
*Shopping Cart*, and then on *Checkout*:

![](./images/user/order6.png)

In the displayed form, you can include an optional name, an optional description, or an optional note. Notes can include
any additional information you want to provide to the sellers of the acquired offerings.

Then, you have to choose a priority for your order, and select one of your shipping addresses.

Once you have provided all the required information you can start the order creation clicking on *Checkout*:

![](./images/user/order7.png)

In the next step, you will be redirected to *PayPal* so you can pay for the offerings according to their pricing models:

![](./images/user/order8.png)

Finally, you will see a confirmation page:

![](./images/user/order9.png)

### Manage Acquired Products

The products you have acquired are located in *My Inventory*, there you can list them, check their status, or download
different assets.

![](./images/user/inv1.png)

In this view, it is possible to filter your products by its status. To do that click on *Filters*, select the related statuses,
and click on *Close*:

![](./images/user/inv2.png)

![](./images/user/inv3.png)

It is also possible to switch between the grid and tabular views using the related buttons:

![](./images/user/inv4.png)

![](./images/user/inv5.png)

You can manage a specific acquired product clicking on it:

![](./images/user/inv6.png)

In the displayed view, you can see the general info of the acquired product, and the characteristics and pricing you have selected.

![](./images/user/inv7.png)

![](./images/user/inv8.png)

![](./images/user/inv9.png)

Additionally, you can see your charges related to the product accessing to the *Charges* tab:

![](./images/user/inv10.png)

In this tab, you will find detailed information of the different charges and you will be able to download the related invoice
clicking on *Download Invoice*:

![](./images/user/inv11.png)

Moreover, this product view allows to download the related assets when the product is digital. To do that click on *Download*:

![](./images/user/inv12.png)

In case the chosen pricing model defines a recurring payment or a usage payment, you will be able to renew your product
clicking on *Renew*. After clicking, you will be redirected to PayPal to pay the related amount.

![](./images/user/inv13.png)

> **Note:** If your product has expired and you do not renew it, it will be suspended, which means you will not have access to the acquired service until you pay.

If the acquired product has a usage based price plan, you will be able to see your current consumption accessing the *Usage* tab:

![](./images/user/inv14.png)

### Manage Requested Orders

Customers can manage some aspects of the orders they have created. To see your requested orders, go to *My Inventory* and
click on *Product Orders*:

![](./images/user/custord1.png)

In the displayed view, you can see the orders you have created, which can be filtered by its status. To do that, click on
*Filters*, select the wanted statuses, and click on *Close*:

![](./images/user/custord2.png)

![](./images/user/custord3.png)

For those orders that include offerings of non digital products, you will be able to cancel them if the seller has not yet started
the process. To do that, locate the order to be canceled and click on *Cancel*:

![](./images/user/custord4.png)

Moreover, you can review the details of the order. To do that click on the date of the order.

![](./images/user/custord5.png)

In the displayed view, you can see all the details of the order, as well as the included products. In addition, you can
leave a note for the seller in the *Notes* tab:

![](./images/user/custord6.png)

To leave a note, write it in the provided text area and click on the send button:

![](./images/user/custord7.png)
