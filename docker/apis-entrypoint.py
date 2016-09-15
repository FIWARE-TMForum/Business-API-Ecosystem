#!/usr/bin/env python
# Credits of this code to @Rock_Neurotiko
from sh import asadmin, cd
from os import getenv

DBUSER = "root"
DBPWD = getenv("MYSQL_ROOT_PASSWORD", "toor")
DBHOST = getenv("MYSQL_HOST", "localhost")
DBPORT = "3306"

APIS = [{
         "bbdd": "DSPRODUCTCATALOG2",
         "war": "DSPRODUCTCATALOG2.war",
         "root": "DSProductCatalog",
         "resourcename": "jdbc/pcatv2"},
        {
         "bbdd": "DSPRODUCTORDERING",
         "war": "productOrdering.war",
         "root": "DSProductOrdering",
         "resourcename": "jdbc/podbv2"},
        {
         "bbdd": "DSPRODUCTINVENTORY",
         "war": "productInventory.war",
         "root": "DSProductInventory",
         "resourcename": "jdbc/pidbv2"},
        {
         "bbdd": "DSPARTYMANAGEMENT",
         "war": "party.war",
         "root": "DSPartyManagement",
         "resourcename": "jdbc/partydb"},
        {
         "bbdd": "DSBILLINGMANAGEMENT",
         "war": "billingManagement.war",
         "root": "DSBillingManagement",
         "resourcename": "jdbc/bmdbv2"},
        {
         "bbdd": "DSCUSTOMER",
         "war": "customer.war",
         "root": "DSCustomerManagement",
         "resourcename": "jdbc/customerdbv2"},
        {
         "bbdd": "DSUSAGEMANAGEMENT",
         "war": "usageManagement.war",
         "root": "DSUsageManagement",
         "resourcename": "jdbc/usagedbv2"}]


def pool(name, user, pwd, url):
    asadmin("create-jdbc-connection-pool",
            "--restype",
            "java.sql.Driver",
            "--driverclassname",
            "com.mysql.jdbc.Driver",
            "--property",
            "user={}:password={}:URL={}".format(user, pwd, url.replace(":", "\:")),
            name)


# asadmin create-jdbc-resource --connectionpoolid <poolname> <jndiname>
def resource(name, pool):
    asadmin("create-jdbc-resource", "--connectionpoolid", pool, name)


def generate_mysql_url(db):
    return "jdbc:mysql://{}:{}/{}".format(DBHOST, DBPORT, db)


# if "install" in sys.argv:
for api in APIS:
    pool(api.get("bbdd"), DBUSER, DBPWD, generate_mysql_url(api.get("bbdd")))
    resource(api.get("resourcename"), api.get("bbdd"))

cd("wars")
for api in APIS:
    try:
        asadmin("deploy", "--force", "false", "--contextroot", api.get('root'), "--name", api.get('root'), api.get('war'))
    except Exception as e:
        print(unicode(e))
        print('API {} could not be deployed'.format(api.get('bbdd')))

cd("..")

