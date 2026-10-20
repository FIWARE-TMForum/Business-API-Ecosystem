# Administrator Guide

This guide explains how marketplace administrators manage the Business API Ecosystem through the web interface. It covers the **Administration** area and the controls for publishing Blog, News & Events, and FAQ content.

Installation, service connections, authentication providers, and deployment defaults are covered in the [Installation and Administration Guide](installation-administration-guide.md) and the [Configuration Guide](configuration-guide.md). Seller and customer workflows are covered in the [User Guide](user-guide.md).

> **Screenshots:** The screenshot placeholders in this guide describe the images to capture from a running marketplace. They are intentionally text placeholders so the documentation can be built before screenshots are available.

(admin-access)=
## Accessing Administration

To access Administration, you need an account with the marketplace administrator role and must use your personal session. After signing in, the initial session is on behalf of your organization, so first switch to your personal session:

1. Sign in with your administrator account.
2. Open the user menu and select **Change session**.
3. Select your own username in the session list to switch from the organization session to your personal session.
4. Open the user menu again and select **Administration**.

The marketplace administrator role name is configured by the deployment.

> **Screenshot placeholder — `admin-personal-session`:** The Change session menu in an organization session, highlighting the user's own username as the option for switching to a personal session.

The Administration page is available at `/admin` on the frontend. On a large screen, its sections appear in the left menu. On a small screen, use the **Administration** dropdown. **Categories** opens by default.

| Menu group | Section | Purpose |
| --- | --- | --- |
| Catalog | Default catalog | Create or update the marketplace's default catalog. |
| Catalog | Categories | Create and update the category hierarchy. |
| Business | Verification | Attach a verifiable credential to a product specification. |
| Business | Revenue sharing | Open the operator revenue-sharing screen; see its current limitations below. |
| Config | Email | Configure outgoing email and contact-request recipients. |
| Config | Analytics | Configure analytics availability, dashboards, and guest-token access. |
| Config | Search | Configure the search engine connection and keyword format. |
| Config | Search & filters | Choose the primary category hierarchy and additional filters. |
| Config | Features | Enable or disable supported marketplace features. |

Accounts with the configured **certifier** role can also enter Administration to use **Verification**. Managing marketplace settings requires the administrator role.

> **Screenshot placeholder — `admin-navigation`:** The user menu with Administration selected and the Administration page showing all three menu groups. Capture the desktop sidebar; a second image can show the mobile dropdown.

## Saving changes

Opening a configuration section loads its current values. Edit the values and use that section's save button to apply your changes. Wait for the success message before leaving the section.

The **Features**, **Search**, **Search & filters**, and **Analytics** settings are saved by the Logic Proxy. Saved feature, search, and analytics values take precedence over their corresponding deployment defaults and persist across proxy restarts. **Email** settings are submitted to the Charging Backend, and catalog and category changes update the catalog service.

After saving, reload the marketplace to load the updated navigation, search behavior, and forms. Other users may also need to reload to see the changes.

The [settings managed through Administration](configuration-guide.md#settings-managed-through-administration) section of the Configuration Guide identifies the related deployment variables and the settings that still require deployment configuration.

(admin-default-catalog)=
## Default catalog

The default catalog provides the category roots used by the marketplace. Configure it before creating the category hierarchy. It is distinct from the catalogs managed by individual sellers.

1. Open **Administration → Default catalog**.
2. If a default catalog exists, the page displays its **Default catalog ID** and loads its name and description. Otherwise, it displays **No default catalog is currently configured**.
3. Enter a **Name**, up to 100 characters, and a **Description**. Both fields are required when creating the catalog.
4. Select **Save default catalog**.
5. Check that the success message and a default catalog ID are displayed.

Saving creates the catalog when none is configured, or updates the configured catalog.

> **Screenshot placeholder — `admin-default-catalog`:** The Default catalog page with its ID, name, description, and Save default catalog button. Use example catalog data.

(admin-categories)=
## Categories

Categories organize the products and offerings that sellers publish. They can form a hierarchy of root categories and nested categories. The **Categories** page displays the hierarchy with category names, status, last update, and edit actions.

With a default catalog configured, this page loads its associated category roots and their descendants. New root categories are associated with the default catalog.

### Creating a category

1. Open **Administration → Categories** and select **Add new category**.
2. In **General**, enter a **Name**, up to 100 characters. Optionally enter a **Description** using the Markdown editor.
3. To create a root category, leave **Choose a parent category** switched off. To create a nested category, switch it on and select its parent from the hierarchy.
4. Select **Next** and review the summary, including the selected parent where applicable.
5. Select **Create category**. The interface returns to the category list after a successful save.

New categories are created with status **Active**.

> **Screenshot placeholder — `admin-category-create`:** The category creation form with a name, Markdown description, and parent selection enabled. Include an example parent and child hierarchy.

### Updating a category

1. In **Categories**, select the edit action for the root or nested category.
2. Update its name, description, parent selection, or status.
3. Select **Next** to review the summary.
4. Select **Update category**.

The editor supports **Active**, **Launched**, **Retired**, and **Obsolete** statuses. Retiring or marking a category obsolete can remove its association with the default catalog, so check the resulting browse hierarchy after saving.

> **Screenshot placeholder — `admin-category-update`:** The category list with an edit action highlighted, followed by the edit form showing the status selector.

Category names also matter when configuring **Search & filters**: the primary root and category-based filter roots are looked up by their exact names. If you rename one of these roots, update the corresponding search configuration.

(admin-verification)=
## Verification

Use **Verification** to attach a verifiable credential to a product specification. This action is available to marketplace administrators and authorized certifiers.

1. Open **Administration → Verification**.
2. In **Product ID**, enter the **product specification ID**.
3. Paste the credential into **Verifiable Credential**.
4. Select **Add**.
5. After the interface returns to Categories, check the product specification to confirm the credential was attached.

The credential is stored as the product specification's `Compliance:VC` characteristic. Uploading another credential replaces the previous value of that characteristic and preserves the other characteristics.

> **Screenshot placeholder — `admin-verification`:** The Verification form showing Product ID, Verifiable Credential, and Add. Use a non-production example credential.

## Operator revenue sharing

**Administration → Revenue sharing** opens **Operator revenue sharing**. The current screen displays a static summary with example data.

Seller revenue-sharing models are a separate workflow described in the [User Guide](user-guide.md).

(admin-email)=
## Email

Use **Administration → Email** to configure the SMTP connection for outgoing messages and the recipients of requests submitted through **Contact us**.

| Field | Value to provide |
| --- | --- |
| SMTP Server | Hostname of the outgoing mail server. |
| SMTP Port | Port supplied by the mail service administrator. |
| Source email | Sender address for outgoing messages. |
| Email User | Username used to authenticate to the SMTP server. |
| Email Password | Password used to authenticate to the SMTP server. |
| General inquiries destination email | Recipient for general contact requests. |
| Technical support destination email | Recipient for technical support requests. |
| Onboarding support destination email | Recipient for onboarding requests. |
| Legal support destination email | Recipient for legal support requests. |

1. Open **Email** and wait for the current configuration to load.
2. Fill in the SMTP fields and all four destination addresses. The form marks these fields as required and checks the email-address format.
3. Enter the SMTP password. For privacy, the password field is blank when the saved configuration is loaded.
4. Select **Add**, which is also the action used to update an existing configuration.
5. Wait for **Email configuration updated successfully**. The interface clears the password field after a successful save.
6. Submit a contact request and confirm it reaches the appropriate support recipient. This checks delivery as well as the saved form values.

The request's support type determines the destination address. **Source email** identifies the sender of outgoing messages.

> **Screenshot placeholder — `admin-email`:** The Email page with the SMTP fields and four contact destination addresses. Leave the password hidden and use example addresses.

(admin-analytics)=
## Analytics

Use **Administration → Analytics** to control analytics availability and configure the dashboards displayed by the marketplace. Obtain the analytics URL, dashboard IDs, and guest-token path from the analytics service administrator.

| Field | Purpose |
| --- | --- |
| Analytics enabled | Enables or disables the analytics integration. |
| Analytics URL | Base URL of the analytics service. |
| Business Insights Non-LEAR | Dashboard ID for the Non-LEAR Business Insights view. |
| Business Insights LEAR | Dashboard ID for the LEAR Business Insights view. |
| Usage Monitor | Dashboard ID for the Usage Monitor view. |
| Guest token path | Path used to request a Superset guest token. The form's default is `/api/v1/dome/guest_token/`. |

The proxy selects the LEAR Business Insights dashboard for accounts with the configured organization administrator role, and the Non-LEAR dashboard otherwise. Usage Monitor requires the marketplace administrator role.

1. Set **Analytics enabled** as required.
2. Enter **Analytics URL**, all three **Dashboard IDs**, and **Guest token path**.
3. Select **Save** and wait for the success message.
4. Reload the marketplace and open Analytics with an account authorized to view the intended dashboards.

The URL, three IDs, and guest-token path are required when saving, including when **Analytics enabled** is off. Prepare the dashboards and access permissions in the analytics service before configuring the integration.

### Using the analytics JSON editor

The **Provide analytics JSON** box contains the current configuration. It offers two actions:

- **Load JSON** copies the JSON values into the form for review. Select **Save** to apply the form values.
- **Save JSON** validates and saves the values in the JSON editor directly.

For example, replace the illustrative URL and IDs below with values supplied for your deployment:

```json
{
  "analyticsEnabled": true,
  "analytics": "https://analytics.example.org",
  "analyticsDashboards": {
    "businessInsightsNonLear": "non-lear-dashboard-id",
    "businessInsightsLear": "lear-dashboard-id",
    "usageMonitor": "usage-dashboard-id"
  },
  "analyticsSuperset": {
    "guestTokenPath": "/api/v1/dome/guest_token/"
  }
}
```

Use the JSON object shown above, with a Boolean `analyticsEnabled` value and non-empty strings for the other values.

> **Screenshot placeholder — `admin-analytics`:** The Analytics form showing the availability switch, URL, three dashboard IDs, guest-token path, and JSON editor with Load JSON and Save JSON.

(admin-search)=
## Search

**Administration → Search** configures the external search engine connection. It is separate from **Search & filters**, which controls the category and filter choices presented to users.

The [TMF Search Engine](https://github.com/SEAMWARE/tmf-search-engine) provides searches over indexed product offerings and catalogs. Its [API usage guide](https://github.com/SEAMWARE/tmf-search-engine/blob/main/doc/api-usage-guide.md) describes the search endpoints and filter behavior.

1. In **Search engine URL**, enter the search service's base URL reachable by the Logic Proxy.
2. When using TMF Search Engine, leave **Use query keyword** switched off. The service receives keywords in the URL path.
3. Select **Save** and wait for the success message.
4. Reload the marketplace and check a keyword search.

The keyword formats are:

| Use query keyword | Product search request | Catalog search request |
| --- | --- | --- |
| Off | `/api/SearchProduct/<keyword>` | `/api/SearchCatalog/<keyword>` |
| On | `/api/SearchProduct?query=<keyword>` | `/api/SearchCatalog?query=<keyword>` |

The proxy adds these paths to **Search engine URL**. Coordinate the keyword format with the search service administrator and run a keyword search after saving to verify the connection.

An empty **Search engine URL** disables the external search integration. This also changes the search availability advertised to the frontend.

> **Screenshot placeholder — `admin-search`:** The Search form with Search engine URL, Use query keyword, and Save.

(admin-search-filters)=
## Search & filters

Use **Administration → Search & filters** to choose the marketplace's primary category hierarchy and additional search filters. Category-based settings can also expose choices in the offering form.

### Primary categories

Choose **Primary categories mode**:

| Mode | Behavior |
| --- | --- |
| `catalogFirstLevel` | Uses the category roots supplied by the default catalog directly as the primary categories. Primary root name and additional filters are disabled. |
| `rooted` | Finds a root category by **Primary root name** and uses its immediate children as the primary categories. Additional filters can be configured. |

For `rooted` mode, create the intended root and child categories first. Enter the exact root name in **Primary root name**; matching is case-sensitive. A root that cannot be found produces no primary category choices.

> **Note:** Selecting `catalogFirstLevel` clears the primary root and additional filters from the form. Saving in this mode stores an empty filter list. Copy the current JSON first if you will need to restore a previous rooted configuration.

### Additional filters

In `rooted` mode, select **Add filter** and fill in the following fields:

| Field | Purpose |
| --- | --- |
| Name | Required identifier sent with the filter. For a configured filter, use a name supported by the search service. |
| Label | Optional display label; the name is used when no label is supplied. |
| Source | `configured` for manually defined options, or `categoryRoot` for options from a category hierarchy. |
| Root name | For `categoryRoot`, the exact name of the root whose immediate children provide the options. |
| Offer form placement | For `categoryRoot`, where to show the filter in the offering form. |

With source **configured**, use **Add option** to define each option's required **Option name** and optional **Option label**. Select **Remove** to remove an option, or **Remove filter** to remove the entire filter. The option name is the value sent to the search service; the label controls its presentation. Configured filters use a flat list of options.

With source **categoryRoot**, define the options by creating child categories under the named root in **Categories**. Names must match the existing category roots exactly.

Category-based filters match the categories attached to offerings. TMF Search Engine supports two ways to combine selected categories: **flat** matches any selected category; **grouped** matches any selection within a category root and requires a match across each selected root. For example, grouped filtering can combine a service category with a deployment model. The search service administrator configures this behavior using the same default catalog as the marketplace; see [Search engine integration](configuration-guide.md#search-engine-integration).

Configured filters match additional indexed offering attributes. For example, a **Procurement type** filter can offer `online` and `tailored` options using the engine's supplied procurement mapper. Before adding a configured filter, agree its **Name** and option values with the search service administrator so they match the deployed filter definitions. The engine's [custom mapping guide](https://github.com/SEAMWARE/tmf-search-engine/blob/main/doc/custom-mapping-guide.md) explains how those definitions are configured.

**Offer form placement** supports these values:

| Value | Behavior |
| --- | --- |
| `none` | Does not add a dedicated field for this filter to the offering form. |
| `generalInfo` | Displays the category-based field in the offering form's General Info section. Only one filter can use this placement. |
| `categorySection` | Displays the category-based field in the offering form's Categories step. |

Offer form placement applies only to `categoryRoot` filters. Changing a filter to `configured` resets its placement to `none`. Changing it to `categoryRoot` clears its manual options.

Select **Save** to save the mode, root, and complete filter list together. Reload the marketplace and check the search choices and offering form.

### Using the searchFilters JSON editor

The **Provide searchFilters JSON** box contains the current configuration. **Load JSON** copies values into the form for review; select **Save** to apply the form values. **Save JSON** saves the values in the JSON editor directly.

Paste only the search-filter configuration object, without wrapping it in a `searchFilters` property. For example:

```json
{
  "primaryCategoriesMode": "rooted",
  "primaryRootName": "Service categories",
  "filters": [
    {
      "name": "deploymentModel",
      "label": "Deployment model",
      "source": "categoryRoot",
      "rootName": "Deployment models",
      "offerFormPlacement": "categorySection"
    },
    {
      "name": "procurementType",
      "label": "Procurement type",
      "source": "configured",
      "children": [
        { "name": "online", "label": "Online purchase" },
        { "name": "tailored", "label": "Tailored procurement" }
      ]
    }
  ]
}
```

Before using this example, create **Service categories** and **Deployment models** as category roots. Have the search service administrator configure `procurementType` with the supplied `dome:map_procurement_type` mapper and index the offerings. The mapper assigns `tailored` when the offering's first price plan uses custom pricing, and `online` otherwise.

> **Screenshot placeholder — `admin-search-filters`:** The rooted configuration form showing Primary root name, one categoryRoot filter with Offer form placement, one configured filter with options, and the JSON controls.

(admin-features)=
## Features

Use **Administration → Features** to enable or disable the following marketplace capabilities. Each row includes the feature name, a description, its configuration key, and a switch.

| Feature | Configuration key | Effect |
| --- | --- | --- |
| Quotes | `quotesEnabled` | Enables quote-request flows and quote pages. |
| Purchases | `purchaseEnabled` | Enables shopping-cart and checkout actions. |
| Tendering | `tenderingEnabled` | Enables tendering features. |
| Data space | `dataSpaceEnabled` | Enables data-space fields in organization and offering forms. |
| DSP | `dspEnabled` | Enables DSP-related dataspace contract and schema fields. |
| Catalog management | `catalogManagementEnabled` | Enables seller catalog list, creation, and update screens in My Offerings. |
| Launch validation | `launchValidationEnabled` | Enables launch-validation requests for offerings. |
| Tender dev actions | `tenderDevButtonsOpenCloseEnabled` | Enables the development controls for opening and closing tenders. |

1. Open **Features** and review the current switches.
2. Turn each feature on or off as required.
3. Select **Save** and wait for **Features configuration saved successfully**.
4. Reload the marketplace and check the affected navigation or workflow.

Configure the supporting service integrations before enabling their features. **Quotes** and **Tendering** require their corresponding service integrations.

Saved switches override the corresponding environment defaults. To change a saved value, return to **Features**, change the switch, and save again.

> **Screenshot placeholder — `admin-features`:** The feature switches documented above, their descriptions, and Save.

(admin-content)=
## Managing Blog, News & Events, and FAQs

Administrators manage public content from the corresponding public page.

| Content | Frontend page | Create action |
| --- | --- | --- |
| Blog | `/blog` | Add a new entry |
| News & Events | `/news` | Add news/event |
| FAQs | `/faq` | Add FAQ |

### Creating content

1. Sign in as an administrator and open the relevant page.
2. Select its create action. This opens the entry editor with the relevant **Content type** selected.
3. For **Blog** or **News / Event**, enter a **Title**, review the generated **URL slug**, and enter the **Content**.
4. Optionally supply a featured image, meta description, excerpt, tags, author, and date. Tags are entered as a comma-separated list. Meta descriptions have a 160-character limit; excerpts have a 300-character limit.
5. For **FAQ**, enter the **Question** and **Answer** instead. The editor hides the article-specific fields.
6. Select **Create entry**. The interface returns to the corresponding public page after creation.

Article slugs use lowercase letters, numbers, and hyphens and must be unique across the stored entries. Saving publishes the content on its corresponding public page.

> **Screenshot placeholder — `admin-content-create`:** The entry editor for a News / Event with its title, slug, optional metadata, featured image control, and content editor. Include a second image showing the simpler FAQ Question and Answer form.

### Editing and deleting content

Open the page containing the entry and select its edit action. The editor loads the saved fields and provides an **Update entry** action. The article detail page also provides management actions for administrators.

> **Current limitation:** In the inspected frontend, the Update entry action returns to the public page without sending the update request. Edits made through this action do not persist. This action needs a frontend fix before it can be used to save changes to existing content.

To delete an entry, select its delete action and confirm in the dialog. Check the public page afterwards to confirm the entry has been removed. Deleting an entry has no undo action in this interface.

> **Screenshot placeholder — `admin-content-manage`:** An example article or FAQ with edit/delete actions visible, plus the deletion confirmation dialog.

<!-- Implementation reviewed: BAE-Frontend c3b1ff5c (src/app/pages/admin, src/app/pages/dome-blog, src/app/offerings/faq, src/app/data, src/app/services); business-ecosystem-logic-proxy fa34cb9e (controllers/admin.js, controllers/tmf-apis/catalog.js, controllers/domeBlog.js, controllers/contactUs.js, lib/search.js, server.js); SEAMWARE/tmf-search-engine b7ab31f (src/app/api/routes.py, src/app/models/api.py, src/app/search, src/app/mappers/dome.py, doc). Deployment defaults were inspected in the local config.js working copy. -->
