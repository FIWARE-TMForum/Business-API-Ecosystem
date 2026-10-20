# Configuration Guide

This guide explains the deployment configuration for the Business API Ecosystem components. Use the configuration
files and environment variables of each service to set its database connections, service endpoints, authentication,
and integration settings. The hostnames and URLs in the examples describe an illustrative deployment; replace them
with the addresses used by your environment.

| Component | Configuration entry points |
| --- | --- |
| Logic Proxy | `config.js`, supported environment overrides, and configuration saved in MongoDB. |
| Charging Backend | `src/settings.py`, `src/services_settings.py`, supported environment overrides, and saved email configuration. |
| BAE Frontend | `src/environments/` at build time and the proxy's `/config` response at startup. |
| TMF APIs | Micronaut `application.yaml` files, profiles, and environment overrides. |
| TMF Search Engine | Service environment variables and the settings described in its own configuration guide. |

Marketplace administrators manage selected runtime settings through the web interface, as described in the
[Administrator Guide](admin-guide.md). Saved settings take precedence over the corresponding deployment defaults.

Restart the affected service after changing its deployment files or environment variables. Rebuild the frontend after
changing its build-time environment; reload the browser after changing runtime settings.

(settings-managed-through-administration)=
## Settings managed through Administration

The current frontend provides the following configuration screens. Use the [Administrator Guide](admin-guide.md) for
the field descriptions and save procedures. The environment variables below provide Logic Proxy deployment defaults;
saved settings from the corresponding screen take precedence for those values.

| Administration screen | Settings | Related environment defaults |
| --- | --- | --- |
| Search | Search engine URL | `BAE_LP_SEARCH_URL` |
| Analytics | Analytics URL and availability | `BAE_LP_ANALYTICS_URL`, `BAE_LP_ANALYTICS_ENABLED` |
| Analytics | Business Insights Non-LEAR dashboard ID | `BAE_LP_ANALYTICS_DASHBOARD_BUSINESS_INSIGHTS_NON_LEAR` |
| Analytics | Business Insights LEAR dashboard ID | `BAE_LP_ANALYTICS_DASHBOARD_BUSINESS_INSIGHTS_LEAR` |
| Analytics | Usage Monitor dashboard ID | `BAE_LP_ANALYTICS_DASHBOARD_USAGE_MONITOR` |
| Analytics | Guest-token path | `BAE_LP_ANALYTICS_SUPERSET_GUEST_TOKEN_PATH` |
| Features | Quotes | `BAE_LP_QUOTE_ENABLED` |
| Features | Purchases | `BAE_LP_PURCHASE_ENABLED` |
| Features | Tendering | `BAE_LP_TENDERING_ENABLED` |
| Features | Data space | `BAE_LP_DATASPACE_ENABLED` |
| Features | DSP | `BAE_LP_DSP_ENABLED` |
| Features | Catalog management | `BAE_LP_CATALOG_MANAGEMENT_ENABLED` |
| Features | Launch validation | `BAE_LP_LAUNCH_VALIDATION_ENABLED` |
| Features | Tender dev actions | `BAE_LP_TENDER_DEV_BUTTON_ENABLED` |

Use **Administration → Search** to save **Use query keyword**, and **Search & filters** to save the category and filter
configuration. Saving the default catalog also stores its ID. The Logic Proxy persists these values in MongoDB and
reloads them for runtime configuration. Update saved values through their Administration screens; they persist across
proxy restarts.

The **Email** screen submits SMTP settings and contact-request destination addresses to the Charging Backend. Its UI
procedure is described under [Email](admin-guide.md#email); the deployment email variables remain documented below.

Database connections, API endpoints, authentication providers, role mappings, service credentials, and other settings
without an Administration control remain deployment configuration. In particular, enabling a feature in the interface
does not configure its supporting service connection or credentials.

### Search engine integration

The Logic Proxy integrates with [TMF Search Engine](https://github.com/SEAMWARE/tmf-search-engine), which indexes TMF
resources in Elasticsearch and provides product-offering and catalog searches. Set `BAE_LP_SEARCH_URL` to its base URL,
or save the URL through **Administration → Search**. With this service, leave **Use query keyword** switched off so the
proxy sends keywords through `/api/SearchProduct/<keyword>` and `/api/SearchCatalog/<keyword>`.

Coordinate the marketplace's **Search & filters** settings with the following variables in the search engine deployment:

| Search engine variable | Relationship to marketplace filters |
| --- | --- |
| `CATEGORY_FILTER_MODE` | `flat` combines all selected categories with OR. `grouped` combines values within the same category root with OR, and combines different roots with AND. |
| `TMF_DEFAULT_CATALOG_ID` | In grouped mode, set this to the default catalog ID displayed in **Administration → Default catalog**. The engine builds its category groups from this catalog's root categories and descendants. |
| `EXTRA_SEARCH_FILTERS` | Defines additional filter names and the mappers used to index their values. Match each configured frontend filter's **Name** to the corresponding engine definition. |

The engine rebuilds the category-group lookup during indexing. When changing the category hierarchy, allow the indexer
to refresh it before checking the resulting grouped searches. Primary category selection in the frontend and category
combination in the search engine are configured independently: `catalogFirstLevel`/`rooted` controls the displayed
hierarchy, while `flat`/`grouped` controls how selected category values are combined.

For example, the configured **Procurement type** filter in the Administrator Guide uses this search engine definition:

```json
[
  {
    "name": "procurementType",
    "mapper": "dome:map_procurement_type"
  }
]
```

Include this entry in the search engine's `EXTRA_SEARCH_FILTERS` array. Its mapper derives `online` or `tailored` from
the offering's first price plan. After changing the filter definitions, run a full reindex as described in the engine's
[configuration guide](https://github.com/SEAMWARE/tmf-search-engine/blob/main/doc/configuration-guide.md).
The [custom mapping guide](https://github.com/SEAMWARE/tmf-search-engine/blob/main/doc/custom-mapping-guide.md) covers
the supplied mappers and additional deployment-specific filters.

## Configuring the Charging Backend

The [Charging Backend](https://github.com/FIWARE-TMForum/business-ecosystem-charging-backend) reads its deployment
settings from `src/settings.py`, which imports service URLs from `src/services_settings.py`. Supported environment
variables override the corresponding file values. Configure these variables in the Charging Backend process or container.

Boolean environment settings in this component use the case-sensitive strings `True` and `False`. For example:

```bash
export BAE_CB_PROPAGATE_TOKEN=True
export BAE_CB_VERIFY_REQUESTS=True
```

### Service endpoints

Provide the complete API base URL for each service, including its deployed base path. The backend appends resource paths
such as `/productOffering`, `/organization`, or `/customerBill` to these URLs.

| Setting | Environment variable | Service |
| --- | --- | --- |
| `SITE` | `BAE_SERVICE_HOST` | Public marketplace URL, used for generated links and payment return URLs. |
| `LOCAL_SITE` | `BAE_CB_LOCAL_SITE` | Charging Backend base URL, used in generated service references. |
| `CATALOG` | `BAE_CB_CATALOG` | Product Catalog Management API. |
| `PARTY` | `BAE_CB_PARTY` | Party Management API. |
| `RESOURCE_CATALOG` | `BAE_CB_RESOURCE_CATALOG` | Resource Catalog API. |
| `SERVICE_CATALOG` | `BAE_CB_SERVICE_CATALOG` | Service Catalog API. |
| `INVENTORY` | `BAE_CB_INVENTORY` | Product Inventory API. |
| `RESOURCE_INVENTORY` | `BAE_CB_RESOURCE_INVENTORY` | Resource Inventory API. |
| `SERVICE_INVENTORY` | `BAE_CB_SERVICE_INVENTORY` | Service Inventory API. |
| `ORDERING` | `BAE_CB_ORDERING` | Product Ordering Management API. |
| `ACCOUNT` | `BAE_CB_BILLING` | Account Management API, including billing accounts. |
| `BILLING` | `BAE_CB_CUSTOMER_BILL` | Customer Bill Management API. |
| `USAGE` | `BAE_CB_USAGE` | Usage Management API. |
| `AUTHORIZE_SERVICE` | `BAE_CB_AUTHORIZE_SERVICE` | Complete Logic Proxy usage-authorization endpoint. |
| `DOME_BILLING_URL` | `BAE_CB_DOME_BILLING_URL` | External DOME billing engine URL when using that billing mode. |

For example, with the all-in-one TMF API service reachable at `http://tmf:8632`:

```bash
export BAE_SERVICE_HOST=https://marketplace.example.org/
export BAE_CB_LOCAL_SITE=http://charging:8006/
export BAE_CB_CATALOG=http://tmf:8632/tmf-api/productCatalogManagement/v4
export BAE_CB_PARTY=http://tmf:8632/tmf-api/party/v4
export BAE_CB_INVENTORY=http://tmf:8632/tmf-api/productInventory/v4
export BAE_CB_ORDERING=http://tmf:8632/tmf-api/productOrderingManagement/v4
export BAE_CB_BILLING=http://tmf:8632/tmf-api/accountManagement/v4
export BAE_CB_CUSTOMER_BILL=http://tmf:8632/tmf-api/customerBillManagement/v4
export BAE_CB_AUTHORIZE_SERVICE=https://marketplace.example.org/authorizeService/apiKeys
```

Use the corresponding individual service URL when deploying the TMF modules separately. Keep these URLs consistent with
[the API base paths](#configuring-the-tmf-apis) and the Logic Proxy endpoint configuration.

### MongoDB

The backend uses Django's `djongo` database engine. Its file configuration has this structure:

```python
DATABASES = {
    "default": {
        "ENGINE": "djongo",
        "NAME": "wstore_db",
        "ENFORCE_SCHEMA": False,
        "CLIENT": {
            "host": "localhost"
        }
    }
}
```

| Environment variable | Purpose |
| --- | --- |
| `BAE_CB_MONGO_SERVER` | MongoDB host. The file default is `localhost`. |
| `BAE_CB_MONGO_PORT` | MongoDB port, converted to an integer. MongoDB's default port is `27017`. |
| `BAE_CB_MONGO_DB` | Database name. The file default is `wstore_db`. |
| `BAE_CB_MONGO_USER` | Optional database username. When provided, the backend sets `authSource` to the configured database name. |
| `BAE_CB_MONGO_PASS` | Database password. |
| `BAE_CB_MONGO_AUTH_MECHANISM` | Optional authentication mechanism passed to the MongoDB client. |

```bash
export BAE_CB_MONGO_SERVER=mongo
export BAE_CB_MONGO_PORT=27017
export BAE_CB_MONGO_DB=charging_db
export BAE_CB_MONGO_USER=charging
export BAE_CB_MONGO_PASS='<database-password>'
```

### Roles and operator identity

Use the same identity-provider role names in the Charging Backend and Logic Proxy.

| Setting in `settings.py` | Default | Environment variable |
| --- | --- | --- |
| `ADMIN_ROLE` | `admin` | `BAE_LP_OAUTH2_ADMIN_ROLE` |
| `PROVIDER_ROLE` | `Seller` | `BAE_LP_OAUTH2_SELLER_ROLE` |
| `CUSTOMER_ROLE` | `Buyer` | `BAE_LP_OAUTH2_CUSTOMER_ROLE` |
| `OPERATOR_ID` | Empty | `BAE_CB_OPERATOR_ID` |
| `RELATED_PARTY_SCHEMA_LOCATION` | Supplied related-party extension schema URL | `BAE_CB_RELATED_PARTY_SCHEMA_LOCATION` |

`SELLER_OPERATOR_ROLE` and `BUYER_OPERATOR_ROLE` are file settings, with defaults `SellerOperator` and `BuyerOperator`.
Set the operator ID to the identifier used by the marketplace operator's party record, and align it with
`BAE_LP_OPERATOR_ID` in the proxy.

### Billing engine and scheduled tasks

`BAE_CB_BILLING_ENGINE` selects the billing implementation:

| Value | Behavior |
| --- | --- |
| `local` | Calculates and manages billing within the Charging Backend. This is the `BILLING_ENGINE` setting's default. |
| `dome` | Uses the DOME billing integration at `BAE_CB_DOME_BILLING_URL`. |

For local billing, set the variable explicitly so the Docker entrypoint also registers and starts the billing cron jobs:

```bash
export BAE_CB_BILLING_ENGINE=local
```

`CRONJOBS` in `settings.py` defines the schedule. With local billing selected, the supplied jobs are:

| Management command | Scheduled times |
| --- | --- |
| `billing_scheduler` | 22:00, 01:00, and 05:00 daily. |
| `payment_scheduler` | 23:00 and 06:00 daily. |
| `retry_pending_terminations` | 03:00 daily. |

Times follow the cron service's timezone. The billing scheduler creates bills for completed billing periods; the payment
scheduler processes bills awaiting payment. The termination job retries pending product terminations. With the `dome`
billing mode, the supplied `CRONJOBS` list contains the termination job.

For a source installation, register the selected schedule from `src/` and run a cron service:

```bash
python3 manage.py crontab add
python3 manage.py crontab show
```

After changing `CRONJOBS`, replace the registered schedule:

```bash
python3 manage.py crontab remove
python3 manage.py crontab add
```

The optional HTTP scheduler endpoints for testing are enabled with `BAE_CB_BILLING_BY_HTTP_TEST_ENABLED=True`.

### Payment providers

`BAE_CB_PAYMENT_METHOD` selects a payment client independently of the billing engine. The file default is `dpas`.

| Value | Provider configuration |
| --- | --- |
| `dpas` | `BAE_CB_DPAS_CLIENT_API_URL` supplies the payment-start endpoint; `DPAS_KEY` supplies the key used to verify payment-provider tokens. |
| `paypal` | `BAE_CB_PAYPAL_CLIENT_ID` and `BAE_CB_PAYPAL_CLIENT_SECRET` supply the application credentials. |
| `stripe` | `BAE_CB_STRIPE_API_KEY` supplies the Stripe API key. |
| `redsys` | `BAE_CB_REDSYS_MERCHANT_CODE`, `BAE_CB_REDSYS_TERMINAL`, `BAE_CB_REDSYS_SECRET_KEY`, `BAE_CB_REDSYS_URL`, and `BAE_CB_REDSYS_QUERY_URL` configure the merchant and payment/query endpoints. |
| `None` | Selects the base payment client for deployments with payment processing disconnected, such as development environments. Use the literal string `None`. |

For example:

```bash
export BAE_CB_PAYMENT_METHOD=paypal
export BAE_CB_PAYPAL_CLIENT_ID='<paypal-client-id>'
export BAE_CB_PAYPAL_CLIENT_SECRET='<paypal-client-secret>'
```

The PayPal client's `MODE` constant in `src/wstore/charging_engine/payment_client/paypal_client.py` selects `sandbox` or
`live`. Its supplied value is `sandbox`. Stripe test integrations can additionally use `BAE_CB_STRIPE_TEST_API_BASE`
to direct requests to a test API endpoint.

### Email notifications

Configure SMTP and the four Contact us destination addresses through [Administration → Email](admin-guide.md#email).
The notification sender reads the saved `EmailConfig` record from MongoDB and uses SMTP with STARTTLS and authentication.
Enter the SMTP password when saving that configuration.

For payout and reporting integrations, `WSTOREMAIL` supplies the sender identity included in their request headers.
Set this value with `BAE_CB_EMAIL` or in `src/settings.py`.

For marketplace notification delivery, complete the SMTP configuration in Administration and check delivery to the
configured support recipients.

### Charging periods and currencies

Edit `CURRENCY_CODES` and `CHARGE_PERIODS` in `src/settings.py` to define the available currencies and charging periods.
Currencies are `(code, name)` pairs, for example `('EUR', 'Euro')`. The supplied period keys and durations are:

| Period key | Days |
| --- | --- |
| `day` | 1 |
| `week` | 7 |
| `month` | 30 |
| `quarter` | 90 |
| `year` | 365 |
| `quinquennial` | 1825 |

### Tokens and asset storage

| Setting or environment variable | Purpose |
| --- | --- |
| `BAE_CB_PROPAGATE_TOKEN` | Whether the backend expects the user access token to be propagated from the proxy. Default: `True`. Align it with the proxy's token-propagation setting. |
| `BAE_CB_VERIFY_REQUESTS` | Certificate verification for outgoing requests that use this setting. Default: `True`. |
| `BAE_CB_MAX_UPLOAD_SIZE` | Maximum in-memory request size in bytes. Default: `52428800` (50 MiB). |
| `AWS_ENABLED` | Enables S3 asset storage with the value `True`. |
| `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` | Credentials for S3 asset storage. |
| `BUCKET_NAME` | S3 bucket used for assets. |
| `ACL_ENABLED` | Enables the configured S3 object ACL behavior with the value `True`. |

The frontend has its own upload-size setting, `MAX_FILE_SIZE`. Configure both limits for the files the deployment accepts.

## Configuring the Logic Proxy

The [Logic Proxy](https://github.com/FIWARE-TMForum/business-ecosystem-logic-proxy) reads `config.js` from the repository
root. Supported environment variables override the file settings at startup. Settings saved through Administration are
loaded from MongoDB as described [above](#settings-managed-through-administration).

Most Boolean environment switches in the proxy use lowercase `true` and `false`.

### Listening address and public URL

| Setting | Environment variable | Purpose |
| --- | --- | --- |
| `config.host` | `BAE_LP_HOST` | Proxy host used in generated internal URLs. The server listens on `config.port`. |
| `config.port` | `BAE_LP_PORT` | HTTP port; the supplied configuration uses `8004`. |
| `config.proxy` | `BAE_SERVICE_HOST` | Public origin, including scheme, host, and optional port, used when the proxy is reached through an ingress or reverse proxy. |
| `config.externalPortal` | `BAE_LP_EXTERNAL_PORTAL` | Public frontend URL, used for the OAuth2 login return to `/dashboard`. |
| `config.corsExposeRedirect` | `BAE_LP_CORS_EXPOSE_REDIRECT` | Exposes the redirect response header when set to `true`. |

```bash
export BAE_LP_HOST=proxy
export BAE_LP_PORT=8004
export BAE_SERVICE_HOST=https://marketplace.example.org/
export BAE_LP_EXTERNAL_PORTAL=https://marketplace.example.org
```

`config.proxyPrefix`, `config.portalPrefix`, `config.logInPath`, and `config.logOutPath` are configured in `config.js`.
The supplied prefixes are empty, and the login/logout paths are `/login` and `/logOut`.

Set `config.sessionSecret` in `config.js` to the session secret for the deployment.

For native HTTPS, set `BAE_LP_HTTPS_ENABLED=true` and provide the TLS files:

```bash
export BAE_LP_HTTPS_ENABLED=true
export BAE_LP_HTTPS_CERT=/certs/server.crt
export BAE_LP_HTTPS_KEY=/certs/server.key
export BAE_LP_HTTPS_CA=/certs/ca.crt
export BAE_LP_HTTPS_PORT=443
```

When TLS is terminated by an ingress and the proxy serves HTTP internally, keep `config.https.enabled=false` in the file
and leave `BAE_LP_HTTPS_ENABLED` unset.

### MongoDB and persisted configuration

The proxy uses MongoDB for its application data and persisted configuration, including the default catalog, feature
switches, search settings, analytics settings, and feedback. Configure its database connection with:

| Environment variable | `config.mongoDb` property |
| --- | --- |
| `BAE_LP_MONGO_SERVER` | `server` |
| `BAE_LP_MONGO_PORT` | `port` |
| `BAE_LP_MONGO_DB` | `db` |
| `BAE_LP_MONGO_USER` | `user` |
| `BAE_LP_MONGO_PASS` | `password` |

```bash
export BAE_LP_MONGO_SERVER=mongo
export BAE_LP_MONGO_PORT=27017
export BAE_LP_MONGO_DB=belp
export BAE_LP_MONGO_USER=proxy
export BAE_LP_MONGO_PASS='<database-password>'
```

For authenticated connections, the proxy uses the configured database as the MongoDB authentication source. The search
engine's Elasticsearch connection is configured in the search engine service.

### Backend API endpoints

Each `config.endpoints` entry has a public `path`, a backend `apiPath`, `host`, `port`, and `appSsl` flag.

- `path` is the alias exposed by the proxy, such as `catalog`.
- `apiPath` is the base path on the target backend, such as `/tmf-api/productCatalogManagement/v4`.
- `host` and `port` identify the target service.
- `appSsl` selects HTTPS for that backend connection.

For example:

```javascript
config.endpoints.catalog = {
    path: 'catalog',
    apiPath: '/tmf-api/productCatalogManagement/v4',
    host: 'tmf',
    port: '8632',
    appSsl: false
};
```

This maps `/catalog/productOffering` at the proxy to
`http://tmf:8632/tmf-api/productCatalogManagement/v4/productOffering`.

The environment pattern is:

```bash
export BAE_LP_ENDPOINT_CATALOG_PATH=/tmf-api/productCatalogManagement/v4
export BAE_LP_ENDPOINT_CATALOG_HOST=tmf
export BAE_LP_ENDPOINT_CATALOG_PORT=8632
export BAE_LP_ENDPOINT_CATALOG_SECURED=false
```

`_PATH` sets the backend `apiPath`. Set the public alias through the entry's `path` property in `config.js`.

| `config.endpoints` key | Supplied public alias | Environment group used after `BAE_LP_ENDPOINT_` |
| --- | --- | --- |
| `catalog` | `catalog` | `CATALOG` |
| `resource` | `resource` | `RESOURCE` |
| `service` | `service` | `SERVICE` |
| `ordering` | `ordering` | `ORDERING` |
| `inventory` | `inventory` | `INVENTORY` |
| `resourceInventory` | `resourceInventory` | `RESOURCE_INVENTORY` |
| `serviceInventory` | `serviceInventory` | `SERVICE_INVENTORY` |
| `party` | `party` | `PARTY` |
| `account` | `account` | `BILLING` |
| `billing` | `billing` | `CUSTOMER_BILL` |
| `customer` | `customer` | `CUSTOMER` |
| `usage` | `usage` | `USAGE` |
| `charging` | `charging` | `CHARGING` |
| `rss` | `rss` | `RSS` |
| `quote` | `quote` | `QUOTE` |
| `document` | `document` | `DOCUMENT` |
| `revenue` | `revenue` | `REVENUE` |
| `invoicing` | `invoicing` | `INVOICING` |
| `search` | `search-bck` | `SEARCH` |

Each group supports `_PATH`, `_HOST`, `_PORT`, and `_SECURED`. Backend hostnames and ports must be reachable from the
proxy process. Configure Charging Backend service URLs to reach the corresponding services from its own process.

### Portal links and integrations

The following deployment settings are returned to the frontend or used to connect marketplace workflows to other services.

| Environment variable | Purpose |
| --- | --- |
| `BAE_LP_DOME_TRUST` | Trust/certification information link. |
| `BAE_LP_DOME_ABOUT` | About link. |
| `BAE_LP_DOME_REGISTER` | Provider registration link. |
| `BAE_LP_DOME_REGISTER_CUSTOMER` | Customer registration link. |
| `BAE_LP_DOME_PUBLISH` | Publishing information link. |
| `BAE_LP_DOME_REGISTRATION_FORM` | Registration form URL. |
| `BAE_LP_DOME_ONBOARDING_GUIDELINES` | Onboarding guide URL. |
| `BAE_LP_DOME_GUIDELINES` | General marketplace guidelines URL. |
| `BAE_LP_KNOWLEDGE_BASE_URL` | Knowledge-base URL. |
| `BAE_LP_TICKETING_URL` | Ticketing-system URL. |
| `BAE_LP_CHAT_URL` | Chat service URL. |
| `BAE_LP_MATOMO_ID`, `BAE_LP_MATOMO_URL` | Matomo site ID and tracker URL. |
| `BAE_LP_GOOGLE_TAG_MANAGER_ID` | Google Tag Manager container ID. |
| `BAE_LP_QUOTE_API` | Quote integration URL. |
| `BAE_LP_LEAR_URL` | LEAR integration URL. |
| `BAE_LP_COMPLIANCE_SERVER_URL` | Compliance service URL. |
| `BAE_LP_BILLING_ENGINE_URL` | Billing preview URL used by the proxy. |
| `BAE_LP_PAYMENT_GATEWAY` | Payment gateway link returned to the frontend. |
| `BAE_LP_PAYMENT_PROVIDER` | Payment-provider selection used by the proxy. |
| `BAE_LP_CONTACT_US_NOTIFICATION_URL` | Complete Charging Backend endpoint used to deliver Contact us notifications. |
| `BAE_LP_OPERATOR_ID` | Marketplace operator's party identifier. |
| `BAE_LP_PARTY_LOCATION` | Related-party extension schema URL. |
| `BAE_LP_PRICE_COMP_SCHEMA` | Price-component extension schema URL. |
| `BAE_LP_OFFERING_SCHEMA` | Offering extension schema URL. |

Without an explicit contact-notification URL, the proxy constructs the target from its Charging Backend endpoint and
`/charging/api/orderManagement/notify/configured`.

`BAE_LP_REVENUE_MODEL` sets the default operator revenue percentage, `BAE_LP_TAX_RATE` sets the tax percentage, and
`BAE_LP_USAGE_CHART` supplies the usage-chart URL. Percentage values are numbers from `0` to `100`.

## Identity Management

Configure authentication in the Logic Proxy and align the returned role names with the Charging Backend.
The OAuth2/OIDC provider is selected through `config.oauth2.provider`; supported provider identifiers include `fiware`,
`keycloak`, `github`, `i4trust`, and `oidc-discover`. Verifiable-credential login uses `config.siop`.

### OAuth2 and OpenID Connect

For example, an OAuth2/OIDC configuration can be provided in `config.js`:

```javascript
config.oauth2 = {
    provider: 'fiware',
    server: 'https://identity.example.org',
    clientID: '<client-id>',
    clientSecret: '<client-secret>',
    callbackURL: 'https://marketplace.example.org/auth/fiware/callback',
    oidc: true,
    oidcScopes: 'openid',
    oidcDiscoveryURI: null,
    oidcTokenEndpointAuthMethod: 'client_secret_basic',
    key: '<oidc-key>',
    defaultRole: null,
    nonce: false
};

config.roles = {
    admin: 'admin',
    seller: 'Seller',
    customer: 'Buyer',
    orgAdmin: 'orgAdmin',
    certifier: 'certifier',
    sellerOperator: 'SellerOperator',
    buyerOperator: 'BuyerOperator'
};
```

Role mappings are top-level `config.roles` settings. The administrator, seller, customer, organization administrator,
and certifier mappings have the following environment overrides:

| Environment variable | Purpose |
| --- | --- |
| `BAE_LP_OAUTH2_ADMIN_ROLE` | Marketplace administrator role. |
| `BAE_LP_OAUTH2_SELLER_ROLE` | Seller role. |
| `BAE_LP_OAUTH2_CUSTOMER_ROLE` | Customer/buyer role. |
| `BAE_LP_OAUTH2_ORG_ADMIN_ROLE` | Organization administrator role. |
| `BAE_LP_OAUTH2_ORG_CERTIFIER_ROLE` | Certifier role. |

The OAuth2/OIDC connection settings are:

| Environment variable | Purpose |
| --- | --- |
| `BAE_LP_OAUTH2_PROVIDER` | Provider identifier. |
| `BAE_LP_OAUTH2_SERVER` | Identity provider base URL. |
| `BAE_LP_OAUTH2_CLIENT_ID` | OAuth2 client ID. |
| `BAE_LP_OAUTH2_CLIENT_SECRET` | OAuth2 client secret. |
| `BAE_LP_OAUTH2_CALLBACK` | Full callback URL registered with the identity provider. |
| `BAE_LP_OAUTH2_DEFAULT_ROLE` | Default role applied by the configured authentication integration. |
| `BAE_LP_OAUTH2_NONCE` | Nonce support, enabled with `true`. |
| `BAE_LP_OAUTH2_IS_LEGACY` | Legacy identity-provider behavior, enabled with `true`. |
| `BAE_LP_OIDC_ENABLED` | OpenID Connect support, enabled with `true`. |
| `BAE_LP_OIDC_SCOPES` | Requested OIDC scopes. |
| `BAE_LP_OIDC_DISCOVERY_URI` | Discovery URL for the discovery-based provider. |
| `BAE_LP_OIDC_TOKEN_AUTH_METHOD` | Token endpoint authentication method. |
| `BAE_LP_OIDC_KEY` | OIDC key setting. |
| `BAE_LP_OIDC_REALM` | Realm when using Keycloak. |
| `BAE_LP_OIDC_TOKEN_KEY` | Signing private key for the iShare integration. |
| `BAE_LP_OIDC_TOKEN_CRT` | Certificate for the iShare integration. |

For Keycloak, set `BAE_LP_OAUTH2_PROVIDER=keycloak` and `BAE_LP_OIDC_REALM` to the realm name. For discovery-based OIDC,
set `BAE_LP_OAUTH2_PROVIDER=oidc-discover` and provide the discovery URI, client credentials, callback, and scopes.

### Verifiable-credential login

Enable VC login with `BAE_LP_SIOP_ENABLED=true`. The proxy uses the `vc` provider and the verifier configuration below.

| Environment variable | Purpose |
| --- | --- |
| `BAE_LP_SIOP_IS_REDIRECTION` | Selects verifier redirection when `true`; otherwise the configured polling flow is used. |
| `BAE_LP_SIOP_CLIENT_ID` | Client identifier used for the login request. |
| `BAE_LP_SIOP_CALLBACK_PATH` | Full callback URL for the VC flow. |
| `BAE_LP_SIOP_REQUEST_URI` | URI used to retrieve the signed login request. |
| `BAE_LP_SIOP_PRIVATE_KEY` | Hex-encoded private signing key. |
| `BAE_LP_SIOP_PRIVATE_KEY_PEM` | PEM signing key used by the JWT signer when provided. |
| `BAE_LP_SIO_SIGN_ALGORITHM` | Signing algorithm; the supplied default is `ES256`. |
| `BAE_LP_SIOP_VERIFIER_HOST` | Verifier base URL. |
| `BAE_LP_SIOP_VERIFIER_QRCODE_PATH` | Verifier QR login path. |
| `BAE_LP_SIOP_VERIFIER_TOKEN_PATH` | Verifier token endpoint path. |
| `BAE_LP_SIOP_VERIFIER_JWKS_PATH` | Verifier JWKS path. |
| `BAE_LP_SIOP_ALLOWED_ROLES` | Comma-separated role names for the configured VC integration. |
| `BAE_LP_SIOP_OPERATORS` | Comma-separated operator identifiers. |

### External identity providers and login controls

`BAE_LP_EXT_LOGIN=true` enables the external identity-provider service. The iShare-related deployment values are
`BAE_EORI`, `BAE_TOKEN_KEY`, and `BAE_TOKEN_CRT`.

| Environment variable | Purpose |
| --- | --- |
| `BAE_LP_SHOW_LOCAL_LOGIN` | Displays local login when set to `true`. |
| `BAE_LP_PROPAGATE_TOKEN` | Propagates the user's access token to backend services when set to `true`. |
| `BAE_LP_ALLOW_LOCAL_EORI` | Enables locally supplied EORI values when set to `true`. |
| `BAE_LP_EDIT_PARTY` | Enables the configured party-editing behavior when set to `true`. |

## Configuring the frontend

The [BAE Frontend](https://github.com/Ficodes/BAE-Frontend) is configured at build time through the files in
`src/environments/`, and at startup through the Logic Proxy's `/config` response.

| File | Build configuration |
| --- | --- |
| `src/environments/environment.ts` | Base environment file imported by the application. |
| `src/environments/environment.development.ts` | Replacement used for the development configuration. |
| `src/environments/environment.production.ts` | Replacement used for the production configuration. |

Set `BASE_URL` in the selected environment file to the browser-accessible Logic Proxy base URL. An empty production
`BASE_URL` uses the frontend's own origin, so configure the ingress to forward backend routes to the proxy when serving
both at one public address. A separate frontend origin can use a full proxy URL.

The frontend loads `/config` during initialization and applies the returned role mappings, default catalog ID, feature
switches, search filters, analytics settings, portal links, tracking settings, and theme name. Configure these values
through the proxy or Administration. After changing a build-time environment file, rebuild the frontend; after changing
runtime settings, reload the browser.

`MAX_FILE_SIZE` in the frontend environment controls accepted upload sizes in bytes. The supplied value is `3145728`
(3 MiB). Align it with the Charging Backend's `BAE_CB_MAX_UPLOAD_SIZE` and the upload limits of the deployment's proxy.

### Frontend themes

Select the frontend theme through `BAE_LP_THEME` on the Logic Proxy. The name is returned as `theme` by `/config` and is
matched case-insensitively against the frontend's `AVAILABLE_THEMES` list in `src/app/themes/index.ts`.
The supplied themes are `BAE` and `DOME`; `BAE` is marked as the frontend's default.

To add or customize a theme:

1. Define its `ThemeConfig` in `src/app/themes/`, including its name, assets, navigation, and component options.
2. Register it in `AVAILABLE_THEMES` in `src/app/themes/index.ts`.
3. Add its styles and assets, and its translated labels under `src/assets/i18n/themes/` as required.
4. Build and deploy the frontend, then select its theme name through `BAE_LP_THEME`.

See the frontend repository's [theming documentation](https://github.com/Ficodes/BAE-Frontend#application-theming-system)
for the theme structure and available customization options.

## Configuring the TMF APIs

The API implementation is [FIWARE TMForum API](https://github.com/FIWARE/tmforum-api). Its single repository contains
Micronaut services backed by an NGSI-LD broker, with individual API modules and an all-in-one application.
Use the release matching the `apis` version in the stack definition; the current stack selects `1.15.1`.
The repository contains the [OpenAPI specifications](https://github.com/FIWARE/tmforum-api/tree/main/api/tm-forum)
and module-specific extensions alongside the implementation.

Configure each deployed module through its `src/main/resources/application.yaml`, environment-specific
configuration, or an external configuration file. The [installation instructions](installation-administration-guide.md#installation)
cover building and starting the services.

The following properties are shared by the API modules:

| Property | Environment equivalent | Purpose |
| --- | --- | --- |
| `micronaut.server.port` | `MICRONAUT_SERVER_PORT` | HTTP listening port. |
| `micronaut.http.services.ngsi.url` | `MICRONAUT_HTTP_SERVICES_NGSI_URL` | NGSI-LD broker base URL. |
| `micronaut.http.services.ngsi.path` | `MICRONAUT_HTTP_SERVICES_NGSI_PATH` | Broker API path, supplied as `ngsi-ld/v1`. |
| `general.contextUrl` | `GENERAL_CONTEXT_URL` | JSON-LD context URL used by the API. |
| `general.serverHost` | `GENERAL_SERVER_HOST` | Reachable API origin used for subscription callbacks. |
| `general.basepath` | `GENERAL_BASEPATH` | Base path used by individually deployed modules. |
| `general.tenant` | `GENERAL_TENANT` | Optional NGSI-LD tenant. |

Micronaut loads additional configuration files through `MICRONAUT_CONFIG_FILES` and selects profiles through
`MICRONAUT_ENVIRONMENTS`. For example, `in-memory,orion-ld` loads the local-cache configuration and the Orion-LD profile. The supplied
`orion-ld` and `scorpio` profiles configure the query syntax for their respective brokers. See the
[Micronaut configuration documentation](https://docs.micronaut.io/4.10.x/guide/#propertySource) for property binding and
configuration-file precedence.

For example, an individually deployed Product Catalog API can use:

```yaml
micronaut:
  server:
    port: 8632
  http:
    services:
      ngsi:
        url: http://orion-ld:1026
        path: ngsi-ld/v1
general:
  contextUrl: https://uri.etsi.org/ngsi-ld/v1/ngsi-ld-core-context.jsonld
  serverHost: http://product-catalog:8632
  basepath: /tmf-api/productCatalogManagement/v4
```

The all-in-one application defines an explicit base path for each API. Common integration paths are:

| API | All-in-one base path |
| --- | --- |
| Product Catalog Management | `/tmf-api/productCatalogManagement/v4` |
| Party Management | `/tmf-api/party/v4` |
| Product Ordering Management | `/tmf-api/productOrderingManagement/v4` |
| Product Inventory | `/tmf-api/productInventory/v4` |
| Resource Catalog | `/tmf-api/resourceCatalog/v4` |
| Service Catalog | `/tmf-api/serviceCatalogManagement/v4` |
| Resource Inventory | `/tmf-api/resourceInventoryManagement/v4` |
| Service Inventory | `/tmf-api/serviceInventory/v4` |
| Account Management | `/tmf-api/accountManagement/v4` |
| Customer Bill Management | `/tmf-api/customerBillManagement/v4` |
| Customer Management | `/tmf-api/customerManagement/v4` |
| Usage Management | `/tmf-api/usageManagement/v4` |
| Quote | `/tmf-api/quote/v4` |
| Document Management | `/tmf-api/documentManagement/v4` |

For an individually deployed module, the supplied `api.<module>.basepath` reads `general.basepath`, defaulting to `/`.
Use the actual configured path when setting the proxy's endpoint `_PATH` and the Charging Backend's service URL.
For all-in-one deployments, use the API-specific paths in the table.

The API's subscription callback origin, broker URL, and configured JSON-LD context must be reachable from the components
that use them. Configure the broker's own persistence in the broker deployment.

### Customer billing extensions

For billing integrations that create or update applied customer billing rates, enable `apiExtension.enabled` in the
Customer Bill Management service. Its configuration, and the all-in-one configuration, read this value from
`API_EXTENSION_ENABLED`:

```bash
export API_EXTENSION_ENABLED=true
```

Set the variable to `false` for deployments using the standard customer-billing controllers.

### Document attachments

The Document Management API can store attachment content in an S3-compatible service. Configure its `s3` properties
in the module or all-in-one configuration:

| Property | Purpose |
| --- | --- |
| `s3.enabled` | Set to `true` to enable attachment storage. The supplied default is `false`. |
| `s3.endpoint` | Object-storage endpoint URL. |
| `s3.accessKey` | Storage access key. |
| `s3.secretKey` | Storage secret key. |
| `s3.bucket` | Attachment bucket name. |
| `s3.maxContentSize` | Maximum inline attachment size in bytes. Default: `10485760` (10 MiB). |
| `s3.region` | Region required by the selected storage provider. |

Document attachments and Charging Backend assets have their own storage configuration. Align the attachment size with
the frontend and ingress limits for document-upload workflows.

## Configuring Themes

For the Angular frontend, use [Frontend themes](#frontend-themes). Its theme definitions are part of the frontend build.

For deployments serving the Logic Proxy's bundled portal, set `config.theme` or `BAE_LP_THEME` to a directory under the
proxy's `themes/`. The bundled portal's collection command merges the theme with its default static resources:

```bash
node collect_static.js
```

The proxy Docker entrypoint also supports `BAE_LP_THEME_URL` for fetching a portal theme and `COLLECT=True` for collecting
portal resources at startup.

## Configuring the RSS

Deployments using the separate [Revenue Sharing Service](https://github.com/FIWARE-TMForum/business-ecosystem-rss)
configure its MySQL connection and role mappings through `/etc/default/rss/database.properties` and
`/etc/default/rss/oauth.properties`, or the following environment overrides:

| File property | Environment variable |
| --- | --- |
| `database.url` | `BAE_RSS_DATABASE_URL` |
| `database.username` | `BAE_RSS_DATABASE_USERNAME` |
| `database.password` | `BAE_RSS_DATABASE_PASSWORD` |
| `database.driverClassName` | `BAE_RSS_DATABASE_DRIVERCLASSNAME` |
| `config.grantedRole` | `BAE_RSS_OAUTH_CONFIG_GRANTEDROLE` |
| `config.sellerRole` | `BAE_RSS_OAUTH_CONFIG_SELLERROLE` |
| `config.aggregatorRole` | `BAE_RSS_OAUTH_CONFIG_AGGREGATORROLE` |

For example:

```bash
export BAE_RSS_DATABASE_URL=jdbc:mysql://mysql:3306/RSS
export BAE_RSS_DATABASE_USERNAME=rss
export BAE_RSS_DATABASE_PASSWORD='<database-password>'
export BAE_RSS_DATABASE_DRIVERCLASSNAME=com.mysql.jdbc.Driver
export BAE_RSS_OAUTH_CONFIG_GRANTEDROLE=admin
export BAE_RSS_OAUTH_CONFIG_SELLERROLE=Seller
export BAE_RSS_OAUTH_CONFIG_AGGREGATORROLE=Aggregator
```

Set the proxy's `RSS` endpoint group to the RSS service used by the deployment. The Charging Backend also exposes its
own RSS routes; select the service URL appropriate to the deployed integration.

## Enabling Production

Build the frontend with its production configuration:

```bash
npm run build -- --configuration production
```

Serve the generated files through the frontend web server and configure the ingress routes to reach the Logic Proxy.
Use a production startup command for the proxy that sets the environment immediately before starting the server:

```bash
NODE_ENV=production node server.js
```

Configure that command in the container's startup configuration when deploying the proxy in a container.

In the Charging Backend's `src/settings.py`, configure production values for `DEBUG`, `ALLOWED_HOSTS`, and `SECRET_KEY`:

```python
DEBUG = False
ALLOWED_HOSTS = ["marketplace.example.org", "charging"]
SECRET_KEY = "<deployment-secret-key>"
```

Keep MongoDB storage persistent for both the proxy and Charging Backend, and persist the search engine's Elasticsearch
data. When using local billing, run the cron service with the selected schedule. Configure the public URLs and the
internal service endpoints for the addresses used by the browser and by each service.
