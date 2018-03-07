from __future__ import unicode_literals

VERIFY_REQUESTS = True

SITE = 'http://proxy.docker:8004/'
LOCAL_SITE = 'http://charging.docker:8006/'

CATALOG = 'http://apis.docker:8080/DSProductCatalog'
INVENTORY = 'http://apis.docker:8080/DSProductInventory'
ORDERING = 'http://apis.docker:8080/DSProductOrdering'
BILLING = 'http://apis.docker:8080/DSBillingManagement'
USAGE = 'http://apis.docker:8080/DSUsageManagement'

RSS = 'http://rss.docker:8080/DSRevenueSharing'

AUTHORIZE_SERVICE = 'http://proxy.docker:8004/authorizeService/apiKeys'
