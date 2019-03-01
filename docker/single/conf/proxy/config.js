var config = {};

// Version of the software
config.version = {
    version: '7.6.0-rc',
    releaseDate: '',
    gitHash: '',
    doc: 'https://fiware-tmforum.github.io/Business-API-Ecosystem/',
    userDoc: 'http://business-api-ecosystem.readthedocs.io/en/develop'
};

// The PORT used by
config.port = 8000;
config.host = 'proxy.docker';

config.extPort = 8004;

// Set this var to undefined if you don't want the server to listen on HTTPS
config.https = {
    enabled: false,
    certFile: 'cert/cert.crt',
    keyFile: 'cert/key.key',
    caFile: 'cert/ca.crt',
    port: 443
};

// Express configuration
config.proxyPrefix = '';
config.portalPrefix = '';
config.logInPath = '/login';
config.logOutPath = '/logOut';
config.sessionSecret = 'keyboard cat';
config.theme = '';

// OAuth2 configuration
config.oauth2 = {
    'server': 'http://idm.docker:8000/',
    'clientID': '',
    'clientSecret': '',
    'callbackURL': 'http://proxy.docker:8004/auth/fiware/callback',
    'roles': {
        'admin': 'provider',
        'customer': 'customer',
        'seller': 'seller',
        'orgAdmin': 'orgAdmin'
    }
};

// Customer Role Required to buy items
config.customerRoleRequired = false;

// MongoDB
config.mongoDb = {
    server: 'mongo',
    port: 27017,
    user: '',
    password: '',
    db: 'belp'
};

// Configure endpoints
config.endpoints = {
    'management': {
        'path': 'management',
        'host': 'localhost',
        'port': config.port,
        'appSsl': config.https.enabled
    },
    'catalog': {
        'path': 'DSProductCatalog',
        'host': 'localhost',
        'port': '8080',
        'appSsl': false
    },
    'ordering': {
        'path': 'DSProductOrdering',
        'host': 'localhost',
        'port': '8080',
        'appSsl': false
    },
    'inventory': {
        'path': 'DSProductInventory',
        'host': 'localhost',
        'port': '8080',
        'appSsl': false
    },
    'charging': {
        'path': 'charging',
        'host': 'localhost',
        'port': '8006',
        'appSsl': false
    },
    'rss': {
        'path': 'DSRevenueSharing',
        'host': 'localhost',
        'port': '8080',
        'appSsl': false
    },
    'party': {
        'path': 'DSPartyManagement',
        'host': 'localhost',
        'port': '8080',
        'appSsl': false
    },
    'billing':{
        'path': 'DSBillingManagement',
        'host': 'localhost',
        'port': '8080',
        'appSsl': false
    },
    'customer': {
        'path': 'DSCustomerManagement',
        'host': 'localhost',
        'port': '8080',
        'appSsl': false
    },
    'usage':  {
        'path': 'DSUsageManagement',
        'host': 'localhost',
        'port': '8080',
        'appSsl': false
    }
};

// Percentage of the generated revenues that belongs to the system
config.revenueModel = 30;

// Billing Account owner role
config.billingAccountOwnerRole = 'bill receiver';

// list of paths that will not check authentication/authorization
// example: ['/public/*', '/static/css/']
config.publicPaths = [];

config.magicKey = undefined;

config.usageChartURL = 'https://mashup.lab.fiware.org/fdelavega/UsageChart?mode=embedded&theme=wirecloud.fiwarelabtheme';

module.exports = config;
