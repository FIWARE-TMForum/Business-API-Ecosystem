# Configuration Guide

This guide covers the different configuration options that are available in order to setup a working Business API
Ecosystem instance. Deployment configuration is provided through settings files and environment variables. Marketplace
administrators can also manage selected settings through the web interface, as described in the [Administrator Guide](admin-guide.md).
Saved interface settings can override the corresponding deployment defaults; see [Settings managed through Administration](#settings-managed-through-administration).

At this step, the different components of the Business API Ecosystem are installed. In the case of the TMForum APIs and
the RSS, this installation process has already required to configure their database connection before their deployment,
so they are already configured. Nevertheless, this section contains an explanation of the function of the different
settings of the RSS properties files.

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

Search's **Use query keyword** option and **Search & filters** are also saved through Administration, without
corresponding environment overrides in the inspected implementation. The default catalog ID is stored when the
administrator saves the default catalog. The Logic Proxy persists these settings in its MongoDB database and reloads
them for runtime configuration. Changing an environment variable or restarting the proxy does not replace a saved
override; change it through the corresponding Administration screen.

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

The Charging Backend creates some objects and connections in the different APIs while working, so the first step is
configuring the different URLs of the Business API Ecosystem components by modifying the file `services_settings.py`,
which by default contains the following content:

```
SITE = 'http://localhost:8004/'
LOCAL_SITE = 'http://localhost:8006/'

CATALOG = 'http://localhost:8080/DSProductCatalog'
INVENTORY = 'http://localhost:8080/DSProductInventory'
ORDERING = 'http://localhost:8080/DSProductOrdering'
BILLING = 'http://localhost:8080/DSBillingManagement'
RSS = 'http://localhost:8080/DSRevenueSharing'
USAGE = 'http://localhost:8080/DSUsageManagement'
AUTHORIZE_SERVICE = 'http://localhost:8004/authorizeService/apiKeys'
```

These settings point to the different APIs accessed by the charging backend. In particular:

- `SITE`: External URL of the complete Business API Ecosystem using for Href creation
- `LOCAL_SITE`: URL where the Charging Backend is going to run
- `CATALOG`: URL of the catalog API including its path
- `INVENTORY`: URL of the inventory API including its path
- `ORDERING`: URL of the ordering API including its path
- `BILLING`: URL of the billing API including its path
- `RSS`: URL of the RSS including its path
- `USAGE`: URL of the Usage API including its path
- `AUTHORIZE_SERVICE`: Complete URL of the usage authorization service. This service is provided by the logic proxy, and is used to generate API Keys to be used by accounting systems when providing usage information.

These settings can be configured using the following environment variables:

```
BAE_SERVICE_HOST=http://proxy.docker:8004/
BAE_CB_LOCAL_SITE=http://charging.docker:8006/
BAE_CB_CATALOG=http://apis.docker:8080/DSProductCatalog
BAE_CB_INVENTORY=http://apis.docker:8080/DSProductInventory
BAE_CB_ORDERING=http://apis.docker:8080/DSProductOrdering
BAE_CB_BILLING=http://apis.docker:8080/DSBillingManagement
BAE_CB_RSS=http://rss.docker:8080/DSRevenueSharing
BAE_CB_USAGE=http://apis.docker:8080/DSUsageManagement
BAE_CB_AUTHORIZE_SERVICE=http://proxy.docker:8004/authorizeService/apiKeys
```

Once the services have been configured, the next step is configuring the database. In this case, the charging backend uses
MongoDB, and its connection can be configured modifying the `DATABASES` setting of the `settings.py` file.

```python
DATABASES = {
    "default": {
        "ENGINE": "djongo",
        "NAME": "wstore_db",
        "ENFORCE_SCHEMA": False,
        "CLIENT": {
            "host": "localhost",
            "port": 27017,
            "username": "mongoadmin",
            "password": "mongopass"
        },
    }
}
```

This setting contains the following fields:

- `ENGINE`: Database engine, must be fixed to `djongo`
- `NAME`: Name of the database to be used
- `CLIENT`: Configuration for connecting to MongoDB
  - `host`: Host of the database. If empty it uses the default `localhost` host
  - `port`: Port of the database. If empty it uses the default `27017` port
  - `username`: User of the database. If empty the software creates a non authenticated connection
  - `password`: Database user password. If empty the software creates a non authenticated connection

These settings can be configured using the environment with the following variables:

```
BAE_CB_MONGO_SERVER=mongo
BAE_CB_MONGO_PORT=27017
BAE_CB_MONGO_DB=charging_db
BAE_CB_MONGO_USER=user
BAE_CB_MONGO_PASS=passwd
```

Once the database connection has been configured, the next step is configuring the name of the IdM roles to be used by
updating `settings.py`:

```python
ADMIN_ROLE = 'provider'
PROVIDER_ROLE = 'seller'
CUSTOMER_ROLE = 'customer'
```

This settings contain the following values:

- `ADMIN_ROLE`: IDM role of the system admin
- `PROVIDER_ROLE`: IDM role of the users with seller privileges
- `CUSTOMER_ROLE`: IDM role of the users with customer privileges

These parameters can be configured with the environment using:

```
BAE_LP_OAUTH2_ADMIN_ROLE=admin
BAE_LP_OAUTH2_SELLER_ROLE=seller
BAE_LP_OAUTH2_CUSTOMER_ROLE=customer
```

The charging backend is the component in charge of maintaining the supported currencies and the timeframe of the different
periods using in recurring pricing models. To configure both, the following settings are used:

```python
CURRENCY_CODES = [
    ('EUR', 'Euro'),
    ('AUD', 'Australia Dollar'),
    ...
]
CHARGE_PERIODS = {
    'daily': 1,  # One day
    'weekly': 7,  # One week
    'monthly': 30,  # One month
    ...
}
```

- `CURRENCY_CODES`: Includes the list of currencies supported by the system as a tuple of currency code and currency name.
- `CHARGE_PERIODS`: Includes the list of supported periods for recurring models, specifying the time (in days) between periodic charges.

The Charging Backend component is able to send email notifications to the users when they are charged or receive a payment.
In this way, it is possible to provide email configuration in the `settings.py` file by modifying the following fields:

```python
WSTOREMAILUSER = 'email_user'
WSTOREMAIL = 'wstore_email'
WSTOREMAILPASS = 'wstore_email_passwd'
SMTPSERVER = 'wstore_smtp_server'
SMTPPORT = 587
```

This settings contain the following values:

- `WSTOREMAILUSER`: Username used for authenticating in the email server
- `WSTOREMAIL`: Email to be used as the sender of the notifications
- `WSTOREMAILPASS`: Password of the user for authenticating in the email server
- `SMTPSERVER`: Email server host
- `SMTPPORT`: Email server port

These settings can be configured with the environment using:

```
BAE_CB_EMAIL=charging@email.com
BAE_CB_EMAIL_USER=user
BAE_CB_EMAIL_PASS=pass
BAE_CB_EMAIL_SMTP_SERVER=smtp.server.com
BAE_CB_EMAIL_SMTP_PORT=587
```

> **Note:** The email configuration is optional. However, the field `WSTOREMAIL` must be provided since it is used internally for RSS configuration.

Additionally, the Charging Backend is the component that charges customers and pays providers. For this purpose it uses
PayPal. For configuring paypal, the first step is setting `PAYMENT_METHOD` to `paypal` in the `settings.py` file:

```python
PAYMENT_METHOD = 'paypal'
```

Then, it is required to provide PayPal application credentials by updating the file `src/wstore/charging_engine/payment_client/paypal_client.py`:

```python
PAYPAL_CLIENT_ID = ''
PAYPAL_CLIENT_SECRET = ''
MODE = 'sandbox'  # sandbox or live
```

These settings contain the following values:

- `PAYPAL_CLIENT_ID`: Id of the application provided by PayPal
- `PAYPAL_CLIENT_SECRET`: Secret of the application provided by PayPal
- `MODE`: Mode of the connection. It can be `sandbox` if using the PayPal sandbox for testing the system. Or `live` if using the real PayPal APIs.

In addition, these settings can be configured using the following environment variables:

```
BAE_CB_PAYMENT_METHOD=paypal
BAE_CB_PAYPAL_CLIENT_ID=client_id
BAE_CB_PAYPAL_CLIENT_SECRET=client_secret
```

The charging backend component can be configured to expect or not the user access token to be propagated
from the business logic proxy component, depending on the use case and the expected plugins to be installed.
This can be configured with the following setting:

```python
PROPAGATE_TOKEN = True
```

This setting can be also configured using the environment as follows:

```bash
export BAE_CB_PROPAGATE_TOKEN=true
```

Moreover, the Charging Backend is the component that activates the purchased services. In this regard, the Charging Backend
has the possibility of signing its acquisition notifications with a certificate, so the external system being offered can
validate that is the Charging Backend the one making the request. To use this functionality it is needed to configure the
certificate and the private Key to be used by providing its path in the following settings of the `settings.py` file:

```python
NOTIF_CERT_FILE = None
NOTIF_CERT_KEY_FILE = None
```

The Charging Backend uses a Cron task to check the status of recurring and usage subscriptions, and for paying sellers.
The periodicity of this tasks can be configured using the `CRONJOBS` setting of `settings.py` using the standard Cron format:

```python
CRONJOBS = [
    ('0 5 * * *', 'django.core.management.call_command', ['pending_charges_daemon']),
    ('0 6 * * *', 'django.core.management.call_command', ['resend_cdrs']),
    ('0 4 * * *', 'django.core.management.call_command', ['resend_upgrade'])
]
```

Once the Cron task has been configured, it is necessary to include it in the Cron tasks using the command:

```bash
$ python3 manage.py crontab add
```

It is also possible to show current jobs or remove jobs using the commands:

```bash
$ python3 manage.py crontab show

$ python3 manage.py crontab remove
```

## Configuring the Logic Proxy

Configuration of the Logic Proxy is located at `config.js` and can be provided in two different ways: providing the values
in the file or using the defined environment variables. Note that the environment variables override the values in `config.js`.

The first settings to be configured are the port and host where the proxy is going to run. In `config.js` they are defined as:

```javascript
config.port = 8004;
config.host = 'proxy.docker';
```

In addition, the environment variables `BAE_LP_PORT` and `BAE_LP_HOST` can be used to override those values.

```bash
export BAE_LP_PORT=8004
export BAE_LP_HOST=proxy.docker
```

If you want to run the proxy in HTTPS you can update the `config.https` setting:

```javascript
config.https = {
    enabled: false,
    certFile: 'cert/cert.crt',
    keyFile: 'cert/key.key',
    caFile: 'cert/ca.crt',
    port: 443
};
```

In this case you have to set `enabled` to true, and provide the paths to the certificate (`certFile`), to the private key (`keyFile`),
and to the CA certificate (`caFile`).

In order to provide the HTTPS configuration using the environment, the following variables have been defined.

```bash
export BAE_LP_HTTPS_ENABLED=true
export BAE_LP_HTTPS_CERT=cert/cert.crt
export BAE_LP_HTTPS_CA=cert/ca.crt
export BAE_LP_HTTPS_KEY=cert/key.key
export BAE_LP_HTTPS_PORT=443
```

The logic proxy supports the BAE to be deployed behind a proxy (or NGINX, Apache, etc) not sending X-Forwarding headers. In this
regard, the following setting is used in order to provide information about the actual endpoint which is used to access to the
Business API Ecosystem:

```javascript
config.proxy = {
    enabled: true,
    host: 'store.lab.fiware.org',
    secured: true,
    port: 443
};
```

Which can be also configured using the `BAE_SERVICE_HOST` environment variable.

```bash
export BAE_SERVICE_HOST=https://store.lab.fiware.org/
```

Then, it is possible to modify some of the URLs of the system. In particular, it is possible to provide a prefix for the API,
a prefix for the portal, and modifying the login and logout URLs:

```javascript
config.proxyPrefix = '';
config.portalPrefix = '';
config.logInPath = '/login';
config.logOutPath = '/logOut';
```

In addition, it is possible to configure the theme to be used by providing its name. Details about the configuration of
Themes are provided in the *Configuring Themes* section:

```javascript
config.theme = 'BAE';
```

The theme can be configured using the `BAE_LP_THEME` variable.

```bash
export BAE_LP_THEME=fiwaretheme
```

The BAE supports multiple external IDPs to be configured in order to allow organizations
to login using their own IDP, when registered in a trust provider like iShare. To enable such feature the following setting
needs to be configured:

```javascript
config.extLogin = true;
```

This setting can be also configured using the environment as follows:

```bash
export BAE_LP_EXT_LOGIN=true
```

Other authentication and behavior flags can also be configured in `config.js`:

```javascript
config.showLocalLogin = false;
config.propagateToken = true;
config.allowLocalEORI = false;
config.editParty = true;
```

They can be configured using the environment as follows:

```bash
export BAE_LP_SHOW_LOCAL_LOGIN=false
export BAE_LP_PROPAGATE_TOKEN=true
export BAE_LP_ALLOW_LOCAL_EORI=false
export BAE_LP_EDIT_PARTY=true
```

Moreover, the Proxy uses MongoDB for maintaining some info, such as the current shopping cart of a user. You can configure
the connection to MongoDB by updating the following setting:

```javascript
config.mongoDb = {
    server: 'mongo',
    port: 27017,
    user: '',
    password: '',
    db: 'belp'
};
```

In this setting you can configure the host (`server`), the port (`port`), the database user (`user`), the database user password
(`password`), and the database name (`db`).

In addition, the database connection can be configured with the environment as following:

```bash
export BAE_LP_MONGO_USER=user
export BAE_LP_MONGO_PASS=pass
export BAE_LP_MONGO_SERVER=mongo
export BAE_LP_MONGO_PORT=27017
export BAE_LP_MONGO_DB=belp
```

As already stated, the Proxy is the component that acts as the endpoint for accessing the different APIs. In this way,
the proxy needs to know the URLs of them in order to redirect the different requests. This endpoints can be configured using the
following settings:

```javascript
config.endpoints = {
    'catalog': {
        'path': 'catalog',
        'apiPath': '',
        'host': 'host.docker.internal',
        'port': '8632',
        'appSsl': false
    },
    'ordering': {
        'path': 'ordering',
        'apiPath': '',
        'host': 'host.docker.internal',
        'port': '8634',
        'appSsl': false
    },

    ...
};
```

The setting `config.endpoints` contains the specific configuration of each API, including:

- `path`: Proxy public path exposed by the logic proxy
- `apiPath`: Base path used in the target backend API
- `host`: Target host
- `port`: Target port
- `appSsl`: Whether the target API is using HTTPS

> **Note:** The default configuration included in the config file is the one used by the installation script, so if you have used the script for installing the Business API Ecosystem you do not need to modify these fields.

Each endpoint can be configured with environment variables with the following pattern:

```bash
export BAE_LP_ENDPOINT_CATALOG_PATH=/catalogManagement/v4
export BAE_LP_ENDPOINT_CATALOG_PORT=8632
export BAE_LP_ENDPOINT_CATALOG_HOST=host.docker.internal
export BAE_LP_ENDPOINT_CATALOG_SECURED=false
```

The same pattern is supported for the configured endpoint groups: `CATALOG`, `RESOURCE`, `SERVICE`, `ORDERING`, `INVENTORY`,
`SERVICE_INVENTORY`, `RESOURCE_INVENTORY`, `CHARGING`, `RSS`, `PARTY`, `BILLING`, `CUSTOMER`, `USAGE`, `CUSTOMER_BILL`,
`QUOTE`, `REVENUE`, `INVOICING`, and `SEARCH`.

For reference, the endpoint-specific environment variables are:

- `RESOURCE`: `BAE_LP_ENDPOINT_RESOURCE_PATH`, `BAE_LP_ENDPOINT_RESOURCE_PORT`, `BAE_LP_ENDPOINT_RESOURCE_HOST`, `BAE_LP_ENDPOINT_RESOURCE_SECURED`
- `SERVICE`: `BAE_LP_ENDPOINT_SERVICE_PATH`, `BAE_LP_ENDPOINT_SERVICE_PORT`, `BAE_LP_ENDPOINT_SERVICE_HOST`, `BAE_LP_ENDPOINT_SERVICE_SECURED`
- `ORDERING`: `BAE_LP_ENDPOINT_ORDERING_PATH`, `BAE_LP_ENDPOINT_ORDERING_PORT`, `BAE_LP_ENDPOINT_ORDERING_HOST`, `BAE_LP_ENDPOINT_ORDERING_SECURED`
- `INVENTORY`: `BAE_LP_ENDPOINT_INVENTORY_PATH`, `BAE_LP_ENDPOINT_INVENTORY_PORT`, `BAE_LP_ENDPOINT_INVENTORY_HOST`, `BAE_LP_ENDPOINT_INVENTORY_SECURED`
- `SERVICE_INVENTORY`: `BAE_LP_ENDPOINT_SERVICE_INVENTORY_PATH`, `BAE_LP_ENDPOINT_SERVICE_INVENTORY_PORT`, `BAE_LP_ENDPOINT_SERVICE_INVENTORY_HOST`, `BAE_LP_ENDPOINT_SERVICE_INVENTORY_SECURED`
- `RESOURCE_INVENTORY`: `BAE_LP_ENDPOINT_RESOURCE_INVENTORY_PATH`, `BAE_LP_ENDPOINT_RESOURCE_INVENTORY_PORT`, `BAE_LP_ENDPOINT_RESOURCE_INVENTORY_HOST`, `BAE_LP_ENDPOINT_RESOURCE_INVENTORY_SECURED`
- `CHARGING`: `BAE_LP_ENDPOINT_CHARGING_PATH`, `BAE_LP_ENDPOINT_CHARGING_PORT`, `BAE_LP_ENDPOINT_CHARGING_HOST`, `BAE_LP_ENDPOINT_CHARGING_SECURED`
- `RSS`: `BAE_LP_ENDPOINT_RSS_PATH`, `BAE_LP_ENDPOINT_RSS_PORT`, `BAE_LP_ENDPOINT_RSS_HOST`, `BAE_LP_ENDPOINT_RSS_SECURED`
- `PARTY`: `BAE_LP_ENDPOINT_PARTY_PATH`, `BAE_LP_ENDPOINT_PARTY_PORT`, `BAE_LP_ENDPOINT_PARTY_HOST`, `BAE_LP_ENDPOINT_PARTY_SECURED`
- `BILLING`: `BAE_LP_ENDPOINT_BILLING_PATH`, `BAE_LP_ENDPOINT_BILLING_PORT`, `BAE_LP_ENDPOINT_BILLING_HOST`, `BAE_LP_ENDPOINT_BILLING_SECURED`
- `CUSTOMER`: `BAE_LP_ENDPOINT_CUSTOMER_PATH`, `BAE_LP_ENDPOINT_CUSTOMER_PORT`, `BAE_LP_ENDPOINT_CUSTOMER_HOST`, `BAE_LP_ENDPOINT_CUSTOMER_SECURED`
- `USAGE`: `BAE_LP_ENDPOINT_USAGE_PATH`, `BAE_LP_ENDPOINT_USAGE_PORT`, `BAE_LP_ENDPOINT_USAGE_HOST`, `BAE_LP_ENDPOINT_USAGE_SECURED`
- `CUSTOMER_BILL`: `BAE_LP_ENDPOINT_CUSTOMER_BILL_PATH`, `BAE_LP_ENDPOINT_CUSTOMER_BILL_PORT`, `BAE_LP_ENDPOINT_CUSTOMER_BILL_HOST`, `BAE_LP_ENDPOINT_CUSTOMER_BILL_SECURED`
- `QUOTE`: `BAE_LP_ENDPOINT_QUOTE_PATH`, `BAE_LP_ENDPOINT_QUOTE_PORT`, `BAE_LP_ENDPOINT_QUOTE_HOST`, `BAE_LP_ENDPOINT_QUOTE_SECURED`
- `REVENUE`: `BAE_LP_ENDPOINT_REVENUE_PATH`, `BAE_LP_ENDPOINT_REVENUE_PORT`, `BAE_LP_ENDPOINT_REVENUE_HOST`, `BAE_LP_ENDPOINT_REVENUE_SECURED`
- `INVOICING`: `BAE_LP_ENDPOINT_INVOICING_PATH`, `BAE_LP_ENDPOINT_INVOICING_PORT`, `BAE_LP_ENDPOINT_INVOICING_HOST`, `BAE_LP_ENDPOINT_INVOICING_SECURED`
- `SEARCH`: `BAE_LP_ENDPOINT_SEARCH_PATH`, `BAE_LP_ENDPOINT_SEARCH_PORT`, `BAE_LP_ENDPOINT_SEARCH_HOST`, `BAE_LP_ENDPOINT_SEARCH_SECURED`

The Business API Ecosystem uses an index system managed by the Logic Proxy in order to perform queries,
searches, and paging. In `config.js` it is configured as follows:

```javascript
config.indexes = {
    'elasticHost': 'https://elastic.docker:9200',
    'user': 'elastic',
    'password': '...'
};
```

The Elasticsearch host can be overridden with:

```bash
export BAE_LP_INDEX_URL=https://elasticsearch:9200
```

In addition, if required by the runtime/client version, the API version can be configured with:

```bash
export BAE_LP_INDEX_API_VERSION=7
```

Finally, there are two fields that allow to configure the behaviour of the system while running. On the one hand, `config.revenueModel`
allows to configure the default percentage that the Business API Ecosystem is going to retrieve in all the transactions.
There is also a `config.taxRate` setting used to configure the tax percentage.
On the other hand, `config.usageChartURL` allows to configure the URL of the chart to be used to display product usage to
customers in the web portal. They can be configured with environment variables `BAE_LP_REVENUE_MODEL`, `BAE_LP_TAX_RATE`,
and `BAE_LP_USAGE_CHART`.

### Additional Logic Proxy Settings

The current `config.js` includes additional settings that can be overridden with environment variables.

OAuth2/OIDC additional variables:

- `BAE_LP_OAUTH2_DEFAULT_ROLE`
- `BAE_LP_OAUTH2_ORG_CERTIFIER_ROLE`
- `BAE_LP_OAUTH2_IS_LEGACY`
- `BAE_LP_OIDC_ENABLED`
- `BAE_LP_OIDC_KEY`

SIOP/VC login variables:

- `BAE_LP_SIOP_ENABLED`
- `BAE_LP_SIOP_IS_REDIRECTION`
- `BAE_LP_SIOP_CLIENT_ID`
- `BAE_LP_SIOP_PRIVATE_KEY`
- `BAE_LP_SIOP_PRIVATE_KEY_PEM`
- `BAE_LP_SIOP_CALLBACK_PATH`
- `BAE_LP_SIOP_REQUEST_URI`
- `BAE_LP_SIOP_VERIFIER_HOST`
- `BAE_LP_SIOP_VERIFIER_QRCODE_PATH`
- `BAE_LP_SIOP_VERIFIER_TOKEN_PATH`
- `BAE_LP_SIOP_VERIFIER_JWKS_PATH`
- `BAE_LP_SIOP_MACHINE_VC_JWT`
- `BAE_LP_SIOP_ALLOWED_ROLES`
- `BAE_LP_SIOP_OPERATORS`
- `BAE_LP_SIO_SIGN_ALGORITHM`

If external login is enabled (`BAE_LP_EXT_LOGIN=true`), additional external IDP variables are used:

- `BAE_EORI`
- `BAE_TOKEN_KEY`
- `BAE_TOKEN_CRT`

DOME and portal URLs:

- `BAE_LP_DOME_TRUST`
- `BAE_LP_DOME_ABOUT`
- `BAE_LP_DOME_REGISTER`
- `BAE_LP_DOME_PUBLISH`
- `BAE_LP_DOME_REGISTRATION_FORM`
- `BAE_LP_DOME_ONBOARDING_GUIDELINES`
- `BAE_LP_DOME_GUIDELINES`
- `BAE_LP_EXTERNAL_PORTAL`
- `BAE_LP_CHAT_URL`
- `BAE_LP_MATOMO_ID`
- `BAE_LP_MATOMO_URL`
- `BAE_LP_KNOWLEDGE_BASE_URL`
- `BAE_LP_TICKETING_URL`
- `BAE_LP_SEARCH_URL`
- `BAE_LP_COMPLIANCE_SERVER_URL`
- `BAE_LP_BILLING_ENGINE_URL`
- `BAE_LP_QUOTE_API`
- `BAE_LP_LEAR_URL`
- `BAE_LP_PAYMENT_GATEWAY`
- `BAE_LP_ANALYTICS_URL`
- `BAE_LP_OPERATOR_ID`
- `BAE_LP_PARTY_LOCATION`

Feature flags:

- `BAE_LP_QUOTE_ENABLED`
- `BAE_LP_TENDERING_ENABLED`
- `BAE_LP_PURCHASE_ENABLED`
- `BAE_LP_DATASPACE_ENABLED`

## Identity Management

Additionally, the proxy is the component that acts as the front end of the Business API Ecosystem, both providing a web portal,
and providing the endpoint for accessing to the different APIs. In this regard, the Proxy includes the IDP and login configuration.
The BAE supports multiple IDP implementations. In particular:

- FIWARE Keyrock
- Keycloak
- GitHub
- FIWARE Keyrock + iShare protocol
- OIDC with discovery server

To configure the IDP integration the setting `oauth2` is used. The following example shows an example configuration using Keyrock:

```javascript
config.oauth2 = {
    'provider': 'fiware',
    'server': 'https://account.lab.fiware.org',
    'clientID': '<client_id>',
    'clientSecret': '<client_secret>',
    'callbackURL': 'http://<proxy_host>:<proxy_port>/auth/fiware/callback',
    'roles': {
        'admin': 'admin',
        'customer': 'customer',
        'seller': 'seller',
        'orgAdmin': 'orgAdmin'
    }
};
```

In this settings, the value of `provider` is used to configure the IDP type. Then,
it is needed to include the IDM instance being used (`server`), the client id given by the IdM (`clientID`),
the client secret given by the IdM (`clientSecret`), and the callback URL configured in the IdM (`callbackURL`).

In addition, the different roles allow to specify what users are admins of the system (`Admin`), what users can create products
and offerings (`Seller`), and what users are admins of a particular organization, enabling to manage its information (`orgAdmin`).
Note that while `admin` and `seller` roles are granted directly to the users in the Business API Ecosystem application, the `orgAdmin`
role has to be granted to users within IdM organizations.

> **Note:** Admin, Seller, and orgAdmin roles are configured in the Proxy settings, so any name can be chosen for them in the IDM.

The OAuth2 settings can be configured using the environment as follows:

```bash
export BAE_LP_OAUTH2_PROVIDER=fiware
export BAE_LP_OAUTH2_SERVER=https://account.lab.fiware.org
export BAE_LP_OAUTH2_CLIENT_ID=client_id
export BAE_LP_OAUTH2_CLIENT_SECRET=client_secret
export BAE_LP_OAUTH2_CALLBACK=http://<proxy_host>:<proxy_port>/auth/fiware/callback
export BAE_LP_OAUTH2_ADMIN_ROLE=admin
export BAE_LP_OAUTH2_SELLER_ROLE=seller
export BAE_LP_OAUTH2_ORG_ADMIN_ROLE=orgAdmin
```

For Keycloak provider some extra settings need to be provided. The following is an example of a Keycloak configuration:

```javascript
config.oauth2 = {
    provider: 'keycloak',
    server: 'http://keycloak.docker:8080',
    clientID: 'bae',
    clientSecret: 'df68d1b9-f85f-4b5e-807c-c8be3ba27388',
    callbackURL: 'http://proxy.docker:8004/auth/keycloak/callback',
    realm: 'bae',
    roles: {
        admin: 'admin',
        customer: 'customer',
        seller: 'seller',
        orgAdmin: 'manager'
    }
}
```

It can be seen that the `provider` setting is set to `keycloak` and that the `realm` setting is used to specify the Keycloak realm.
Such setting can be configured using the environment using:

```bash
export BAE_LP_OIDC_REALM=bae
```

When using the iShare protocol, the configuration requires the certificate issued by iShare to be provided in order to generate
and sign the JWT used in such a protocol. Such info can be provided by the settings `tokenCrt` and `tokenKey` or via environment with:

```bash
export BAE_LP_OIDC_TOKEN_KEY=...
export BAE_LP_OIDC_TOKEN_CRT=...
```

Finally, if the OIDC protocol is used the following settings need to be configured:

- `oidcScopes`: Scopes requested in the OIDC request
- `oidcDiscoveryURI`: Discovery endpoint for the OIDC protocol
- `oidcTokenEndpointAuthMethod`: Method used for retrieving the access token in the OIDC server

Such settings can be configured with the environment using:

```
BAE_LP_OIDC_SCOPES
BAE_LP_OIDC_DISCOVERY_URI
BAE_LP_OIDC_TOKEN_AUTH_METHOD
```

## Configuring the TMF APIs

When the TMF APIs are deployed from sources, the connection to the MySQL database is configured during the installation process
setting up the jdbc connection as described in the *Installation and Administration* guide.

On the other hand, the Docker image `biz-ecosystem-apis`, which is used to deploy TMF APIs using Docker, uses two environment
variables for configuring such connection.

```
MYSQL_ROOT_PASSWORD=my-secret-pw
MYSQL_HOST=mysql
```

Finally, the TMF APIs can optionally use a configuration file called `settings.properties` which is located by default at `/etc/default/apis`.
This file includes a setting `server` which allows to provide the URL used to access to the Business API Ecosystem and, in particular, by the APIs
in order to generate *hrefs* with the proper reference.

```
server=https://store.lab.fiware.org/
```

This setting can also be configured using the environment variable `BAE_SERVICE_HOST`:

```bash
export BAE_SERVICE_HOST=https://store.lab.fiware.org/
```

## Configuring the RSS

The RSS has its settings included in two files located at `/etc/default/rss`. The file `database.properties` contains
by default the following fields:

```
database.url=jdbc:mysql://localhost:3306/RSS
database.username=root
database.password=root
database.driverClassName=com.mysql.jdbc.Driver
```

This file contains the configuration required in order to connect to the database.

- `database.url`: URL used to connect to the database, this URL includes the host and port of the database as well as the concrete database to be used
- `database.username`: User to be used to connect to the database
- `database.password`: Password of the database user
- `database.driverClassName`: Driver class of the database. By default MySQL

In addition, database settings can be configured using the environment. In particular, using the following variables:

```bash
export BAE_RSS_DATABASE_URL=jdbc:mysql://mysql:3306/RSS
export BAE_RSS_DATABASE_USERNAME=root
export BAE_RSS_DATABASE_PASSWORD=my-secret-pw
export BAE_RSS_DATABASE_DRIVERCLASSNAME=com.mysql.jdbc.Driver
```

The file `oauth.properties` contains by default the following fields (it is recommended not to modify them):

```
config.grantedRole=admin
config.sellerRole=Seller
config.aggregatorRole=aggregator
```

This file contains the name of the roles (registered in the idm) that are going to be used by the RSS.

- `config.grantedRole`: Role in the IDM of the users with admin privileges
- `config.sellerRole`: Role in the IDM of the users with seller privileges
- `config.aggregatorRole`: Role of the users who are admins of an store instance. In the context of the Business API Ecosystem there is only a single store instance, so you can safely ignore this flag

Those settings can also be configured using the environment as:

```bash
export BAE_RSS_OAUTH_CONFIG_GRANTEDROLE=admin
export BAE_RSS_OAUTH_CONFIG_SELLERROLE=Seller
export BAE_RSS_OAUTH_CONFIG_AGGREGATORROLE=Aggregator
```

## Configuring Themes

The Business API Ecosystem provides a basic mechanism for the creation of themes intended to customize the web portal
of the system. Themes include a set of files which can override any of the default portal files located in the `public/resources`
or `views` directories of the logic proxy. To do that, themes map the directory structure and include files with the same
name of the default ones to be overridden.

The Logic Proxy can include multiple themes which should be stored in the `themes` directory located at the root of the
project.

To enable themes, the `config.theme` setting is provided within the `config.js` file of the Logic Proxy. Themes are
enabled by providing the name of the theme directory in this setting.

```javascript
config.theme = 'dark-theme';
```

> **Note:** Setting `config.theme` to an empty string makes the Business API Ecosystem use its default theme.

To start using a theme the following command has to be executed:

```bash
$ node collect_static.js
```

This command merges the theme files and the default ones into a `static` directory used by the Logic Proxy to retrieve
portal static files.

## Enabling Production

The default installation of the Business API Ecosystem deploys its different components in *debug* mode. This is useful
for development and testing but it is not adequate for production environments.

Enabling the production mode makes the different components to start caching requests and views and minimizing JavaScript
files.

To enable the production mode, the first step is setting the environment variable `NODE_ENV` to `production` in the machine
containing the Logic Proxy.

```bash
$ export NODE_ENV=production
```

Then, it is needed to collect static files in order to compress JavaScript files.

```bash
$ node collect_static.js
```

Finally, change the setting `DEBUG` of the Charging Backend to `False`.

```python
DEBUG=False
```
