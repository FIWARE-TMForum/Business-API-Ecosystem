# User Guide

This guide explains how to use the Business API Ecosystem marketplace with its default **BAE theme** to discover services,
purchase and manage products, and publish offers as a provider. Instructions and screenshot placeholders use the BAE
interface and its English labels.

Access to workspaces and actions depends on your permissions and the features enabled by the marketplace operator.

(admin)=
(manage-categories)=
(manage-idps)=
Marketplace administration is covered in the separate [Administrator Guide](admin-guide.md).

| Task | Where to go |
| --- | --- |
| Update personal or organization information | User menu → **Profile** → **General**. |
| Maintain billing details | **Profile** → **Billing addresses**. |
| Discover services | **Browse** → **Services**. |
| Browse provider catalogues | **Browse** → **Providers catalogues**. |
| Complete a purchase | Cart icon or user menu → **My shopping cart**. |
| Review purchases, sales, and invoices | User menu → **Product Orders**. |
| Manage acquired products and subscriptions | User menu → **My inventory**. |
| Publish specifications and product offers | User menu → **My Offerings**. |
| Negotiate a tailored offer | User menu → **Quotes**. |
| Invite providers to respond to a request | User menu → **Tenders**. |
| View marketplace reports | User menu → **Analytics**. |

## Getting started

You can browse public offers and provider pages before signing in. Select **Login** to authenticate using the method
provided by your marketplace. Follow the identity provider's instructions or, for credential-based login, complete the
wallet verification shown in the redirected page or QR-code window.

After login, the header shows the initials of the active account. Open this menu to access your profile, orders,
inventory, and other workspaces. The initial session represents your organization. Check the organization shown in the
menu before creating offers, submitting requests, or ordering products: those operations use the active session.

On small screens, open the main menu to access the navigation and account options. Use the appearance selector to
choose **Light**, **Dark**, or **System** as the display mode.

> **Screenshot placeholder — UG-01:** Signed-in header with the organization name and expanded user menu.

## Using Organizations

An organization has its own profile, billing addresses, specifications, offers, orders, and inventory. Work in the
organization session when acting on its behalf. Your permissions within that organization determine the actions available.

To change session when **Change session** is available:

1. Open the user menu in the header.
2. Select **Change session**.
3. Choose the organization to represent, or choose your own username to use your personal session.
4. Check the name in the user menu before continuing.

The profile and workspace lists reload for the selected session. Choose the session before preparing an order or editing
a specification or offer.

Marketplace administrators access Administration through their personal session. First switch to your own username,
then reopen the user menu and select **Administration**. The [Administrator Guide](admin-guide.md) explains that workflow.

> **Screenshot placeholder — UG-02:** Change session menu with an organization and the personal username.

## Profile Configuration

Open the user menu and select **Profile**. The **General** section displays the profile of the active person or organization.
The profile workspace also provides **Billing addresses**, **Revenue sharing**, **Payment dashboard**, and **VC Issuer**.

### Personal information

In a personal session, **General** displays account information and an editable personal profile. The user ID, email,
and access token come from the authenticated account.

Fill in **Name** and **Lastname**, which are required, and optionally provide:

- Treatment, gender, marital status, and nationality.
- Birth date, city of birth, and country of birth.

Select **Update** to save the profile.

> **Screenshot placeholder — UG-03:** Personal profile showing the account information and editable fields; mask the access token and personal data.

### Organization information and contacts

In an organization session, **General** displays the organization profile. Organization administrators can edit it.

| Field | Information to provide |
| --- | --- |
| Name | Organization name; required. |
| Website | Organization website. |
| Country | Select the organization's country; required. |
| Description | Public organization description, with Markdown formatting and a preview. |
| Organization logo | Upload a logo or enter its image URL. Use a square logo with a transparent background. |

Where dataspace integration is enabled, the profile also includes **Contract Management Address**,
**Contract Management Client ID**, and **Contract Management Scopes**. Use the connection details supplied for your
organization's contract-management service; enter multiple scopes separated by commas.

The **Contact information** table contains the organization's public contacts. To add one:

1. Under **Add a new contact medium**, choose **Email**, **Postal Address**, or **Phone Number**.
2. Enter a **Title** identifying the contact, such as “Sales” or “Technical support.”
3. Supply the email address, postal address, or phone number. For a phone, select the country prefix.
4. Select **Save** to add the contact to the table.
5. Select **Update** to save the organization profile, including the contact changes.

Use the row actions to edit or remove a contact, then save the profile with **Update**. Organization details and contacts
are used on public provider pages and when preparing compliance requests.

> **Screenshot placeholder — UG-04:** Organization profile with logo, description, and contact-information table.

### Billing addresses

Open **Profile** → **Billing addresses** to maintain the addresses used at checkout. Organization administrators maintain
the addresses of their organization.

To create an address, complete **Add billing address**:

| Field | Required information |
| --- | --- |
| Title | A name that helps you recognize the address. |
| Country | Select a country. |
| City | City or town. |
| State / Province | State, province, or region. |
| ZIP / Postal Code | Postal code. |
| Street Address | Street and building details. |
| Email | Billing contact's email address. |
| Phone number | Billing contact's number, with the country prefix selected separately. |

You can also choose a **Phone Type**, such as Office or Mobile. Select **Add billing address** to save.
To edit an existing entry, use its edit action, change the fields, and select **Update billing address**.

These addresses are also available in checkout and when submitting subscription changes.

> **Screenshot placeholder — UG-05:** Billing-address list and the add/edit form with sample business details.

### Revenue sharing and external account services

Select **Profile** → **Revenue sharing** to view the provider's revenue-sharing information. The report presents the
sections, values, and links supplied for the active account.

**Payment dashboard** opens the connected payment provider's portal. Use it to manage the payment services associated
with your account. **VC Issuer** opens the configured credential issuer for credential-related tasks.

> **Screenshot placeholder — UG-06:** Provider revenue-sharing information, using sample values.

## Customer

### List Available Offerings

Open **Browse** → **Services** to discover offers. From **Home**, you can also select **Browse services**, enter keywords
in the home page's search box, or select **View Services** on a category card to open its offers.

On the results page:

1. Select a category from the heading's dropdown, or choose **All Categories**.
2. Enter keywords in the search box and select **Search**, where keyword search is available.
3. Use the filter buttons above the results to select relevant values. Available filters and their labels are defined by
   the marketplace; examples include delivery model, compliance level, sector, and procurement type.
4. Narrow the category selection using the **Filters** sidebar or **Categories** panel.
5. Use **Clear all** to reset filters, and the grid/list controls to change the presentation.
6. Select **Load more** to display further results, then open an offer to review it.

The selected values are reflected in the filter controls. Filters can support multiple values, depending on their setup.

Open **Browse** → **Providers catalogues** to browse published catalogues. Use the search box to find a catalogue,
choose grid or list view, and open a catalogue card. Its page shows the provider's description, country, support contacts,
and the catalogue's services. Use **Browse services**, the category selector, and the service filters to explore its offers.

> **Screenshot placeholder — UG-07:** Offer results with keyword search, an active category, selected filter values, and grid/list controls.

> **Screenshot placeholder — UG-08:** Catalogue page opened through Browse → Providers catalogues, with provider details, support contacts, and services.

### Offering details

Open an offer to review its overview and provider. The details page groups information into three tabs:

| Tab | Information available |
| --- | --- |
| Overview | Product description, how it works, key features, business benefits, use cases, FAQs, and product attachments. |
| Pricing | Available price plans, configuration options, and usage metrics. |
| Compliance | Certification level, compliance evidence, terms and conditions, downloadable terms documents, and SLA information where provided. |

The page also identifies the offer version, last update, product, and owner. Use **Read more** or **Read all** where shown
to expand longer descriptions, and select attachment actions to open supporting documents.

Sign in to acquire an offer. **Add to cart** opens the configuration and pricing drawer. For tailored offers, use
**Create quote** to send the provider your requirements; see [Quotes](#quotes).

> **Screenshot placeholder — UG-09:** Offer detail page with Overview, Pricing, and Compliance tabs and its acquisition action.

### Create Order

First select the organization or personal session that will make the purchase and ensure it has a billing address.

To add an offer to the cart:

1. Open the offer and select **Add to cart**.
2. Choose a price plan. A free offer is identified as free.
3. Set the configuration options shown for the plan. Depending on the option, select a value, use a range control, or
   turn a Boolean switch on or off. Optional options can be enabled or disabled.
4. For a plan with a configuration profile, review the predefined values.
5. Where usage metrics are shown, enter sample usage values to simulate the price. These values provide an estimate;
   charges for usage depend on the service usage actually recorded.
6. Review the displayed charges and accept the terms and conditions when the acceptance checkbox is shown.
7. Select **Add to cart**. You can use **Undo** in the confirmation message to remove the item just added.

A plan can include several charges, such as a one-time setup charge and a recurring subscription. Review each component
and its charging period.

> **Screenshot placeholder — UG-10:** Purchase drawer with a price plan, configurable options, usage estimate, terms acceptance, and calculated charges.

Open the header's cart icon to review the cart, or choose **My shopping cart** from the user menu to open checkout.
Remove any unwanted items before submitting the order.

At checkout:

1. Review the **Contact Person** details for the session.
2. Select a **Billing Address**. Use **Add** to create another address; the form is displayed directly if none exists.
3. Optionally enter an **Order Note** for the provider.
4. Review **Your Order**, including the selected offers and charges.
5. Select **Checkout**.
6. Complete the payment-provider flow if the marketplace redirects you for payment, then return to the marketplace.

The subsequent fulfillment follows the procurement mode set by the provider. Track the request in **Product Orders**
and the acquired products in **My inventory**.

> **Screenshot placeholder — UG-11:** Checkout with contact details, selected billing address, order note, and order summary.

### Manage Requested Orders

Open **Product Orders** from the user menu and select **Product Orders** → **As Customer**.

Use **Filter by action** to select acquisition (**Add**), configuration change (**Modify**), or termination (**Delete**)
orders. Use **Filter by status** to narrow the list to Acknowledged, In Progress, Partial, Completed, Failed, Pending,
or Cancelled orders.

Each row identifies the order, state, billing address, and date. Open its details action to see the full order ID,
customer and billing information, and individual items. Item details include the selected price plan, action, and state.
An order can contain items at different stages; review the item states as well as the overall order state.

Use the notes action to open **Order Notes**. Read the conversation, type a message, and select **Send** to add it to
the order. Notes include their author and date.

> **Screenshot placeholder — UG-12:** Customer order list with action/status filters and an order-details dialog.

### Invoices

Open **Product Orders** → **Invoices** → **As Customer**. The list shows the invoice date, number, tax-inclusive amount,
and state.

Use the download action to retrieve an invoice. Open its details to inspect **Applied Billing Rates**, including the
charge name, description, type, amount, related product, and covered period where present.

> **Screenshot placeholder — UG-13:** Invoice list and Applied Billing Rates details, with sample invoice data.

### Manage Acquired Products

Open **My inventory** from the user menu. The workspace contains **Products**, **Services**, and **Resources**.

In **Products**, filter by Created, Active, Suspended, or Terminated to find an acquisition. Open the product name to
review its description, start date, selected price plan, and configuration. Where provided, the inventory views also show
the services and resources associated with the product.

For an active product, use **Modify characteristics** to request a change:

1. Open the product card's **Modify characteristics** action.
2. Review the current configuration and choose the new price plan and option values in the drawer.
3. Select **Modify Characteristics**.
4. Select the billing address for the change and choose **Confirm changes**.
5. Complete payment if requested, then follow the **Modify** order in **Product Orders**.

To end an active subscription, select **Unsubscribe**, confirm the subscription, and complete the billing-address
selection shown for the termination request. Track the resulting **Delete** order in **Product Orders**.

In **Services** and **Resources**, filter the records by their available states and open a record's ID to inspect its
description and characteristics. These records describe the service or resource instances associated with acquisitions.

> **Screenshot placeholder — UG-14:** Product inventory showing status filters and Modify characteristics / Unsubscribe actions.

> **Screenshot placeholder — UG-15:** Subscription configuration change and billing-address confirmation.

## Seller

### Seller workspace

Open the user menu and select **My Offerings**. This workspace is available to accounts with provider permissions in
the active session.

The sidebar separates the objects used to build and sell a service:

| Section | Purpose |
| --- | --- |
| Product offers | Define how customers acquire a product, including categories, terms, prices, and procurement. |
| Specifications → Products | Describe the product, its presentation, configurable options, supporting specifications, and compliance evidence. |
| Specifications → Services | Define service specifications that can be linked to a product. |
| Specifications → Resources | Define resource specifications that can be linked to a product. |
| Pay per use metrics | Define the measurements available for usage-based pricing. |
| Catalogues | Manage your catalogues when catalogue management is enabled. |

The sidebar shows counts for each type. Lists provide status tabs, row actions, last-update information, and **Load more**
when further records are available.

A typical publication workflow is:

1. Prepare and validate service and resource specifications if the product needs them.
2. Define and validate pay per use metrics if the offer will use usage-based pricing.
3. Create a product specification and validate it for use in offers.
4. Create a product offer, select its product specification, and complete its commercial details.
5. Preview the result and publish the offer from **Product offers**.

Specification validation makes a specification available for use in the marketplace's forms. Compliance verification
submits evidence for assessment. Offer publication makes the commercial offer available to customers.

> **Screenshot placeholder — UG-16:** My offerings workspace with specification sections, counts, status tabs, and row actions.

### Manage Catalogs

When **Catalogues** is available in the sidebar, create a catalogue before selecting it in a product offer:

1. Open **Catalogues** and select **Add new catalogue**.
2. Enter a **Name**, up to 100 characters, and an optional Markdown **Description**.
3. Select **Next step** and review the summary.
4. Select **Create catalogue**.
5. Use the catalogue's actions menu to **Publish** it when ready.

Use **Edit** to update the name and description, review the summary, and select **Update catalogue**. Publication is
managed through the list actions: **Publish**, **Unpublish**, and **Delete**, according to the catalogue's current state.
Unpublish a published catalogue before deleting it.

When the marketplace uses automatic catalogue assignment, the offering workflow assigns your provider catalogue.

> **Screenshot placeholder — UG-17:** Catalogue list with status tabs and Publish / Unpublish actions, plus the catalogue summary.

### Service and resource specifications

Open **My Offerings** → **Services** or **Resources** and use the add-new-specification button.

1. In **General Info**, provide a **Name**, up to 100 characters, and an optional **Description**.
2. Select **Save and continue** to open **Configuration options**.
3. Add any configurable parameters using the [configuration-option editor](#configuration-options).
4. Complete the form and choose **Save as draft** or **Validate service specification** / **Validate resource specification**.

Drafts let you return to the work later. Validated service and resource specifications can be selected in a product
specification. Use the list's **Draft**, **Validated**, and **Deleted** tabs and its **Edit**, **Validate**, and **Delete**
actions to manage them.

> **Screenshot placeholder — UG-18:** Service or resource specification form and its draft/validation choice.

### Manage Product Specifications

Open **My Offerings** → **Products** and select **Add new product specification**. The editor contains the following
steps; use **Save and continue** to advance and **Back** to return.

| Step | Fields and actions |
| --- | --- |
| General Info | Required product name and product image; optional supporting attachments. |
| Product details | Required product description and How it works; optional key features, business benefits, and use cases. |
| Configuration options | Optional configurable parameters that can be used in pricing and acquisition. |
| Dataspace configuration | Connection and policy information when dataspace functionality is enabled. |
| Service specifications | Optional links to validated service specifications. |
| Resource specification | Optional links to validated resource specifications. |
| FAQs | Optional product questions and answers. |
| Compliance profile | Self-attestation and supporting compliance documents. |

**General Info.** Enter a name of up to 100 characters and upload a product image. The image selector accepts SVG, PNG,
JPG, and GIF, with a displayed limit of 3 MB. You can replace or remove the selected image. Add optional PDF or Word
attachments with the supporting-document selector; its displayed limit is also 3 MB per file.

**Product details.** Complete **Product description** and **How it works**, using the Markdown editor and preview. Each
editor displays a 2,000-character limit. These texts appear in the public offer's Overview tab.

Use **Add key feature**, **Add business benefits**, and **Add use cases** to describe the product in more detail. Each
entry has a name and description; a key feature also has an icon. Save the entry, then use its row menu to edit or delete
it. These entries appear as distinct sections of the public product page.

**Linked specifications.** Search for validated service and resource specifications, select the ones used by the product,
and remove selected entries with their remove controls.

**FAQs.** Select **Add FAQ**, then enter the question and answer. A question can contain up to 200 characters and an
answer up to 2,000. Expand an entry to edit it, or remove it with its delete action.

**Saving and validating.** Complete the form and select **Save and create product**, or **Save changes** when editing. In the
confirmation dialog, choose **Save as draft** to return later or **Validate product specification** to make it available
for offers. A draft requires the required general information and product details to be complete.

To resume work, return to **Products**, choose **Draft** or **Validated**, and use **Edit** on the specification.
The list also provides **Validate** for drafts and a confirmed **Delete** action.

When leaving a creation form with changes, the dialog offers continuing, discarding changes, or **Leave and save draft**
when the required information is complete. Confirm the save action before leaving the editor.

> **Screenshot placeholder — UG-19:** Product specification General Info and Product details, including image, attachments, and structured feature entries.

> **Screenshot placeholder — UG-20:** Product specification editor showing linked specifications, FAQs, and the save/validate dialog.

### Configuration options

Product, service, and resource specifications use the configuration-option editor. In a product specification, these
options determine what customers can configure and what providers can use to define standard or flexible pricing.

Select **Add configuration option** and complete:

| Field | What to provide |
| --- | --- |
| Name | Required option name, up to 100 characters. |
| Type | String, Number, Number range, or Boolean. |
| Description | Explanation of the option and its meaning. |
| Is this configuration optional? | Choose whether customers can disable the option. |
| Values | The permitted values or range, according to the type. |

For **String**, enter each permitted choice and select **Add value**. For **Number**, supply a number and unit for each
choice. For **Number range**, provide **From**, **To**, and a unit, then add the range. For **Boolean**, set the default
value with the **Default value is true** control.

Select **Save configuration option** to add it to the specification. Use the option's row menu to edit or delete it.

For example, a product can define a “Storage” number range from 10 to 1,000 GB, a “Support” string option with Standard
and Premium values, and an optional backup feature. An offer can then use these options in a configuration profile or
price components.

> **Screenshot placeholder — UG-21:** Configuration-option editor with type, optional setting, values, and a numeric range example.

### Compliance verification

Use the product specification's **Compliance profile** step to provide evidence for the verification service:

1. Select **Self attestation** to download the template.
2. Complete the document and upload it under **Upload self attestation**.
3. Add supporting compliance documents under **Additional attachments**, and wait for uploads to finish.
4. Save the specification. Open it again with **Edit** when preparing the verification request.
5. Select **Request validation** to review the evidence and organization information.
6. Check the organization name, VAT identifier, address, country, website, and email. Complete the organization profile
   first if the dialog identifies missing information.
7. Select **Request Validation** in the dialog to submit the request.

After assessment, the offer's **Compliance** tab displays the certification level and available evidence. The displayed
levels include No level, Baseline, Professional, and Professional+.

> **Screenshot placeholder — UG-22:** Compliance profile with uploaded self-attestation and the validation-request dialog showing evidence and organization details.

### Dataspace configuration

When dataspace functionality is enabled, product specifications include a **Dataspace configuration** step. Use it to
add the credentials configuration and authorization-policy information required by the service. These configuration
entries use JSON values.

Where DSP integration is enabled, select **DSP compatible** in **General Info** for a product using that integration.
Complete its dataspace settings:

- Add at least one endpoint, with its name, URL, and description.
- Provide the **Upstream address**, **Transfer type**, and optional **Transfer path**.
- Complete the target specification, service configuration, credentials configuration, and policy configuration as valid JSON.

For offers based on a DSP-compatible product specification, a **Contract definition** step becomes available. Enable
**DSP contract definition** and provide the **Access policy** and **Contract policy** JSON supplied for the service.

> **Screenshot placeholder — UG-23:** Dataspace product configuration and the offer's Contract definition step, using sample connection and policy data.

### Pay per use metrics

Open **My Offerings** → **Pay per use metrics** and select **New pay per use metric**.

1. In **General Info**, enter a name that is unique for your provider and an optional Markdown description.
2. In **Metrics**, select **Create new metric**. Enter the metric's name and optional description, then select **Save metric**.
3. Add the other measurements needed by the service. At least one metric is required.
4. Review **Summary** and save the usage specification.
5. Return to the list and use **Validate** to make it available to usage-based price components.

Use **Edit** to update a specification. The **Draft**, **Validated**, and **Deleted** tabs organize the list. Before deleting
a metric specification, remove its use from active offers; the confirmation dialog identifies offers that still use it.

For example, define a usage specification for a storage service with a “Transferred GB” metric, then select that
specification and metric in the offer's usage price component.

> **Screenshot placeholder — UG-24:** Pay per use metric editor with General Info, Metrics, and Summary, plus the list's Validate action.

### Manage Product Offerings

Open **My Offerings** → **Product offers** and select **New product offer**. First prepare a validated product
specification, which you will select in the offer.

The offer editor uses **General Info**, **Category**, **Terms & Conditions**, **Price plans**, and **Procurement Mode**.
For DSP-enabled products, it also includes **Contract definition**. Use **Save and continue** and **Previous step** to
move between steps. The step indicators show progress and required information to complete.

**General Info** contains:

| Field | What to provide |
| --- | --- |
| Name | Required offer name, up to 100 characters. |
| Product Specifications | Select a validated product specification. |
| Catalogue | Select your catalogue when catalogue management is enabled. |
| Marketplace-specific selection | Complete any required additional selector configured by the marketplace. |
| Product overview | Optional short description, up to 300 characters. |

The product specification supplies the detailed product presentation and configuration options. It remains associated
with the offer after creation.

In **Category**, select a required root category and, where appropriate, its subcategory. Add up to five **Tags** to
help describe the offer: type a tag and press Enter. Each tag can contain up to 20 characters; remove a tag with its
remove control. Complete any additional fields presented for the marketplace's categories.

In **Terms & Conditions**, write or paste the terms using the Markdown editor. You can also attach terms documents
with **Browse files**. The selector accepts PDF and Word documents and displays a 5 MB limit. Review the listed files
and remove any that should not be included.

Continue with the [price plans](#price-plans) and [procurement settings](#procurement-and-external-billing).

> **Screenshot placeholder — UG-25:** Offer editor with General Info, Category, tags, and the Terms & Conditions text/file controls.

### Price plans

In the offer's **Price plans** step, select how the service is priced:

| Pricing option | Customer workflow |
| --- | --- |
| Free | Customers acquire the offer without a price charge. |
| Tailored pricing | Customers send their requirements and negotiate a proposal with the provider. |
| Online paid price | Customers select a priced plan and configure the offer for purchase. |

For **Tailored pricing**, select **Add price plan**, enter a required name and an optional description, and select
**Save price plan**. Add at least one plan. The description can contain up to 300 characters and should explain the
scope of the tailored service.

For **Online paid price**, select **Add price plan** and choose its type:

- **Standard plan**: a plan with a predefined configuration profile. Choose the values included in this plan from the
  product specification's configuration options.
- **Flex plan**: a plan whose options customers can configure. Price components can be linked to the selected values
  or ranges.

Standard plans are available for product specifications with configuration options. A Flex plan can also contain
charges that apply independently of a particular option.

For an online paid plan:

1. Enter a required **Name** and **Description**. The name can contain up to 100 characters and the description up to 300.
2. Review **Relevant Configuration Options**. Use **Choose Options** to control which options and values are available
   in the plan. For a range, set its available lower and upper bounds within the specification's range.
3. For a Standard plan, use **Set configuration profile** to choose the included value for each option and save the profile.
4. Select the plan's **Currency**: EURO, US DOLLAR, or POUND. All its price components use that currency.
5. Add at least one [price component](#price-components-and-tiers).
6. Select **Save price plan** to return to the plan list.

A predefined configuration profile and per-plan option restrictions are alternative ways to define the configuration.
Use the profile controls for a predefined configuration, or **Choose Options** to restrict the customer's choices.
Values already used by a price component remain available to that component.

Use the plan's actions menu to **Edit** or **Delete** it. Save the offer after completing changes to its plans.

> **Screenshot placeholder — UG-26:** Price plans step showing Free, Tailored pricing, and Online paid price, with Standard/Flex plan selection.

> **Screenshot placeholder — UG-27:** Paid-plan editor with relevant options, configuration profile, currency, and price components.

### Price components and tiers

Select **Add price component** inside an online paid plan. Enter a name, optional description, and non-negative
**Base price**, then select the **Price type**:

| Price type | Additional settings |
| --- | --- |
| One time | A single charge. |
| Recurring | Select a Daily, Weekly, Monthly, or Yearly charging period. |
| Recurring-prepaid | Select the period for the prepaid recurring charge. |
| Usage | Select a validated **Usage specification** and one of its **Metric** values. |

For a Flex plan, optionally link the component to a **Configuration option**. For an option with individual choices,
select the **Value** to which the component applies. For a numeric range, define its price tiers.

To include a discount, enable **Include a discount**, enter its amount, and choose **Percentage (%)** or **Fixed amount**.
Provide the duration and duration unit. Review the final price where the form displays it.

Select **Save price component**. Use the component's actions menu to edit or delete it.

**Range-based tiers.** Select a range configuration option in a Flex component and add tiers in **Tier list**:

1. Set the tier's **Min.** and **Max.** within the product option's range, using the fields or sliders.
2. Enter the **Price** and **Price type**.
3. Complete the recurring period or usage specification/metric if required by that type.
4. Optionally give the tier a name and description and include a discount.
5. Select **Save tier** and repeat for the remaining ranges.
6. Cover the complete configuration range with valid tiers, then select **Save price component**.

The editor identifies uncovered ranges and invalid intervals. Review the tier table before saving the component and
then save the price plan.

> **Screenshot placeholder — UG-28:** Price-component editor showing a recurring or usage charge and discount settings.

> **Screenshot placeholder — UG-29:** Flex component with range tiers, minimum/maximum controls, and complete range coverage.

### Procurement and external billing

In **Procurement Mode**, choose how the service will be processed:

| Mode | Workflow |
| --- | --- |
| Manual | The provider manages payment and fulfillment manually. |
| Payment Automatic - Procurement Manual | Payment uses the connected payment service; the provider handles fulfillment. |
| Automatic | Payment and procurement use the automated service flow. |

To use a mode with automatic payment, first connect a payment gateway through your payment-provider account. The form
provides **Check the payment gateway here** when the provider portal is available. You can also open **Profile** →
**Payment dashboard**.

If the offer uses an external billing service, select **Set external billing** and enter its **External billing engine URL**.
Use the service endpoint supplied for that offer's billing integration.

> **Screenshot placeholder — UG-30:** Procurement Mode selector, external billing URL, and payment-provider link.

### Preview, drafts, and publication

Use **Preview** in the offer editor to inspect **Product details** and **Card preview**. Check the product presentation,
pricing information, categories, and compliance content before saving.

On the final step, select **Create offer** or **Update offer**. Review the confirmation preview and select
**Confirm & publish** or **Confirm & update**, as shown. Use **Back to edit** to make further changes.

Manage public availability from **Product offers**:

| Tab | Available work |
| --- | --- |
| Draft | Complete or edit offers and publish those marked **Ready to be published**. |
| Published | Edit, duplicate, or unpublish an offer. |
| Retired | Review unpublished offers and publish them again when ready. |
| Deleted | Review archived offers. |

To publish a saved offer, open its row's actions menu and select **Publish**. A complete offer includes its product,
category, and procurement details. Use **Edit** to finish an offer marked **Not completed**.

Use **Unpublish** to withdraw a published offer from sale. **Duplicate** creates a draft based on a published offer;
review and edit it before publication. For draft or retired offers, use **Delete** and confirm the dialog to archive them.

When leaving a new offer with changes, choose **Continue editing**, **Discard changes**, or **Leave and save draft**.
Saving a draft requires an offer name, selected product specification, and a catalogue where the catalogue selector is
required. Return through **Draft** to finish the offer.

> **Screenshot placeholder — UG-31:** Offer preview with Product details / Card preview tabs and confirmation actions.

> **Screenshot placeholder — UG-32:** Product offers list showing Draft, Published, Retired, and Deleted tabs, status badges, and publication actions.

### Manage Received Orders

Open **Product Orders** → **Product Orders** → **As Provider**. Filter by action or status and open an order's details
to review the customer, billing contact, and requested items.

For order items handled through manual procurement, use the available item actions to progress fulfillment:

1. Acknowledge a new item or cancel it.
2. Move an acknowledged item to **inProgress** when processing starts.
3. Complete an item in progress, or mark it **failed** when fulfillment fails.
4. Review and confirm the requested state change in the confirmation dialog.

Use **Order Notes** to discuss requirements and progress with the customer. The order action identifies whether the
request acquires a product, changes its configuration, or terminates a subscription.

Open **Product Orders** → **Invoices** → **As Provider** to review customer invoices. You can inspect their applied
billing rates, download an invoice, and edit its invoice number with the row's edit/save actions.

> **Screenshot placeholder — UG-33:** Provider order details with item-state actions, confirmation dialog, and order notes.

## Quotes

Quotes support services whose scope and price need to be agreed with the customer. When enabled, the user menu's
**Quotes** entry opens the **Tailored offerings Dashboard**, with **As Customer** and **As Provider** views.

### Request a tailored offer

1. Open a tailored offer's detail page and select **Create quote**.
2. In **Request Quote**, review the product and provider.
3. Enter **Message / Requirements**, with at least 10 characters, explaining the scope, configuration, quantities, or
   questions the provider should consider.
4. Set the required **Request Date** for the quote.
5. Select **Send Request** and close the confirmation.
6. Open **Quotes** → **As Customer** to follow the request.

Use **Filter by status** to find a request and **Refresh** to reload the dashboard. The rows identify the request date,
other party, product, and current status.

> **Screenshot placeholder — UG-34:** Request Quote form and customer tailored-offerings dashboard.

### Negotiate and accept a proposal

Open a request's **Details** to review the participants, request, dates, state, and attachments. The dialog explains the
current stage and available actions. Use **Chat** to exchange messages with the other party; messages remain associated
with the quote.

The tailored-offer workflow is:

1. The provider opens **Quotes** → **As Provider**, reviews the request, and sets an **Expected Date** for delivering
   the proposal.
2. The provider selects **Accept Quote** and confirms to begin preparing the proposal.
3. The provider uploads the proposal as a PDF attachment, up to 10 MB. The submitted proposal becomes available to the customer.
4. The customer opens **Details**, downloads the proposal, and uses **Chat** to discuss it.
5. The customer selects **Accept Quote** and confirms when satisfied with the proposal. The available **Cancel Quote**
   action can end the negotiation instead.
6. After acceptance, the provider uses **Create Offer** to prepare the agreed customer-specific offer.

The dashboard describes the successive stages as request sent/received, request accepted, offering submitted,
and offering accepted. Use the state explanation in **Details** to see the next action for your role.

> **Screenshot placeholder — UG-35:** Quote details showing expected date, proposal PDF, role-specific acceptance action, and Chat.

### Create the agreed customer-specific offer

As the provider, open the accepted quote's **Details** and select **Create Offer**. The marketplace opens the offer
workflow for the agreed product and customer.

1. Review the selected customer in the first step.
2. In **Price plans**, choose **Free** or **Online paid price** for the agreed offer. For online pricing, add a plan
   with its name and description, and define its price components and any configuration profile.
3. Select the **Procurement Mode** and any external billing connection.
4. Review the summary, which identifies the customer for the exclusive offer.
5. Select **Create product offer**.

The customer can then acquire the agreed offer through the marketplace's order process.

The customer-specific pricing editor uses drawers for the plan, its configuration profile, and its price components.
Use **Add Tier Pricing** for range-based pricing, then save the plan before advancing to procurement. The pricing type
is shared by the plans in this offer; choose it before adding plans.

> **Screenshot placeholder — UG-36:** Customer-specific offer summary identifying the customer, agreed price plans, and procurement settings.

## Tenders

Tenders let a customer send a common request to several providers and compare their proposals. When enabled, open
**Tenders** from the user menu. The dashboard provides **As Buyer** and **As Provider** views.

### Create and submit a tender

In **As Buyer**, select **Create Tender**:

1. Enter the required **Tender Title** and select **Save**.
2. Set **Tender Start Date** and **Tender End Date**. Use the date fields or picker; the end date must follow the start date.
3. Upload the required **PDF Attachment** describing the request. The limit is 10 MB.
4. Select **Next: Select Providers**.
5. Narrow the provider candidates using **All Categories**, **Compliance Levels**, **Addressable Sectors**, **Country**,
   and **Integration Framework**. Use **Clear all** to reset these filters.
6. Select the providers to invite and choose **Save Providers List**.
7. Review **Already Invited Providers**. Add other providers or remove invitations as needed before submission.
8. Select **Submit Tender** and confirm **Finalize** to notify the invited providers.

Saving the title creates a tender you can continue preparing. Before submission, use **Edit** on the dashboard to
complete the tender, replace its request document, or adjust its provider list.

> **Screenshot placeholder — UG-37:** Tender creation with title, date fields, and the required PDF request.

> **Screenshot placeholder — UG-38:** Tender provider selection with filters, selected candidates, invited providers, and Submit Tender.

### Follow responses and select an offer

In **As Buyer**, the dashboard shows the tender title, status, start and end dates, and request attachment. Expand a
submitted tender to see **Related Provider Quotes**, with each provider's state, attachments, chat, and details.

The tender's status progresses through **Not Yet Submitted**, **Invites Sent, Waiting Acceptance**, **Tender Started**,
and **Tender Closed**. Check its dates and current status before expecting provider proposals or selecting a response.

Use **Broadcast** on an expanded tender, or **Broadcast Message** in its details, to send the same message to all invited
providers. Use a provider quote's **Chat** for an individual conversation.

As an invited provider:

1. Open **Tenders** → **As Provider** and select **Details** on the request.
2. Review the customer request PDF and tender dates.
3. Set the expected proposal date when requested, then use **Accept Invite** to participate, or **Cancel Quote** to decline.
4. When the tender is open for proposals, upload the response PDF using the attachment control in **Details**.
5. Follow the request's state and use **Chat** for clarifications with the customer.

After the tender closes, the buyer can review the proposals, open the chosen provider quote, and select **Accept Quote**.
Confirming the selection accepts that proposal and rejects the other provider offers in the tender. The selected provider
can then use **Create Offer** to prepare the customer-specific offer.

Use **Cancel Tender** in the tender's details to cancel the tender and its related requests; review the confirmation
before proceeding.

> **Screenshot placeholder — UG-39:** Buyer tender dashboard expanded to show provider responses, attachments, chat, and offer selection.

## Analytics and support

When **Analytics** is available in the user menu, open it to view **Business Insights**, which presents the configured
marketplace business dashboard. Use the dashboard's own controls to explore its data. **Open Superset** opens the
reporting service in a separate tab where available.

> **Screenshot placeholder — UG-40:** Analytics Business Insights dashboard with its available report controls.

Select **Blog** in the header to read published articles. The **News & Events** and **FAQ** pages are accessible at
`/news` and `/faq`. Open an article to read its full content. Provider pages also list the organization's support contacts.

Open **Knowledge Base** or **Ticketing System** from the user menu for documentation and support. To share your
experience with the marketplace, select **Feedback** in the page footer, choose a rating, enter your comments, and send
the feedback.

The **Contact us** form is accessible at `/contact-us`. It includes support type, first name, last name, email,
organization, role in the organization, and message. Complete the required fields and privacy/terms acceptance,
optionally choose marketing communications, and submit the form.

> **Screenshot placeholder — UG-41:** BAE footer Feedback action and feedback dialog; a second image shows the /contact-us form and submission confirmation, using sample details.
