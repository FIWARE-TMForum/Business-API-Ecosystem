#!/usr/bin/env python3

from sh import git, cd, mvn, mysql, mysqldump, sed, asadmin, npm, node, cp, virtualenv, bash, mkdir, rm, bash
from os.path import isfile
import click
import os.path
import pymysql
import shutil

DBUSER = "root"
DBPWD = "toor"
DBHOST = "localhost"
DBPORT = 3306

APIS = [{"url": "https://github.com/FIWARE-TMForum/DSPRODUCTCATALOG2.git",
         "branch": "v7.4.0",
         "bbdd": "DSPRODUCTCATALOG2",
         "war": "target/DSProductCatalog.war",
         "root": "DSProductCatalog",
         "name": "catalog",
         "resourcename": "jdbc/pcatv2"},
        {"url": "https://github.com/FIWARE-TMForum/DSPRODUCTORDERING.git",
         "branch": "v7.4.0",
         "bbdd": "DSPRODUCTORDERING",
         "war": "target/DSProductOrdering.war",
         "root": "DSProductOrdering",
         "name": "ordering",
         "resourcename": "jdbc/podbv2"},
        {"url": "https://github.com/FIWARE-TMForum/DSPRODUCTINVENTORY.git",
         "branch": "v7.4.0",
         "bbdd": "DSPRODUCTINVENTORY",
         "war": "target/DSProductInventory.war",
         "root": "DSProductInventory",
         "name": "inventory",
         "resourcename": "jdbc/pidbv2"},
        {"url": "https://github.com/FIWARE-TMForum/DSPARTYMANAGEMENT.git",
         "branch": "v7.4.0",
         "bbdd": "DSPARTYMANAGEMENT",
         "war": "target/DSPartyManagement.war",
         "root": "DSPartyManagement",
         "name": "party",
         "resourcename": "jdbc/partydb"},
        {"url": "https://github.com/FIWARE-TMForum/DSBILLINGMANAGEMENT.git",
         "branch": "v7.4.0",
         "bbdd": "DSBILLINGMANAGEMENT",
         "war": "target/DSBillingManagement.war",
         "root": "DSBillingManagement",
         "name": "billing",
         "resourcename": "jdbc/bmdbv2"},
        {"url": "https://github.com/FIWARE-TMForum/DSCUSTOMER.git",
         "branch": "v7.4.0",
         "bbdd": "DSCUSTOMER",
         "war": "target/DSCustomerManagement.war",
         "root": "DSCustomerManagement",
         "name": "customer",
         "resourcename": "jdbc/customerdbv2"},
        {"url": "https://github.com/FIWARE-TMForum/DSUSAGEMANAGEMENT.git",
         "branch": "v7.4.0",
         "bbdd": "DSUSAGEMANAGEMENT",
         "war": "target/DSUsageManagement.war",
         "root": "DSUsageManagement",
         "name": "usage",
         "resourcename": "jdbc/usagedbv2"}]

rss = {"url": "https://github.com/FIWARE-TMForum/business-ecosystem-rss.git",
       "branch": "v7.4.0",
       "bbdd": "RSS",
       "war": "fiware-rss/target/DSRevenueSharing.war",
       "name": "rss",
       "root": "DSRevenueSharing"}

charg = {"url": "https://github.com/FIWARE-TMForum/business-ecosystem-charging-backend.git",
         "branch": "v7.4.0",
         "name": "charging"}

proxy = {"url": "https://github.com/FIWARE-TMForum/business-ecosystem-logic-proxy.git",
         "branch": "v7.4.0"}


@click.group(chain=True)
def cli():
    pass


def clone_and_checkout(url, branch="master"):
    name = url.split("/")[-1][:-4]
    if os.path.isdir(name):
        print("Name already cloned")
    else:
        print("Cloning {} from {}".format(name, url))
        git("clone", url)
    print("cd {}".format(name))
    cd(name)
    print("checkout {}".format(branch))
    git("checkout", branch)
    print("End clone")
    cd("..")


@cli.command("clone")
def clone():
    for api in APIS + [rss, charg, proxy]:
        clone_and_checkout(api.get("url"), api.get("branch"))


def maven(direct, *extra):
    print("cd {}".format(direct))
    cd(direct)
    print("Maven install")
    mvn("install", *extra)
    print("Maven done")
    cd("..")


@cli.command("maven")
def maveninstall():
    for api in APIS:
        url = api.get("url")
        apiname = url.split("/")[-1][:-4]
        maven(apiname)

    maven("business-ecosystem-rss", "-DskipTests")


def createtable(name, user, pwd):
    try:
        print("Creating MySQL table: {}".format(name))
        mysql("-u", user, "-p{}".format(pwd), "-e", "CREATE DATABASE IF NOT EXISTS {};".format(name))
        print("MySQL table created")
        return 0
    except:
        print("MySQL failed")
        return -1


@cli.command("tables")
def createtables():
    for api in APIS + [rss]:
        createtable(api.get("bbdd"), DBUSER, DBPWD)


def fix_persistence(text):
    text = text.replace("jdbc/sample", "jdbc/pcatv2")\
               .replace("<provider>org.eclipse.persistence.jpa.PersistenceProvider</provider>", "")\
               .replace("<property name=\"eclipselink.ddl-generation\" value=\"drop-and-create-tables\"/>", "")\
               .replace("<property name=\"eclipselink.logging.level\" value=\"FINE\"/>", "")

    dropandcreate = "<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"/>"
    if dropandcreate not in text:
        text = text.replace("</properties>", "\t{}\n\t\t</properties>".format(dropandcreate))

    return text


@cli.command("persistence")
def modify_persistence():
    for api in APIS:
        url = api.get("url")
        name = url.split("/")[-1][:-4]
        text = ""

        settsf = "{}/src/main/java/org/tmf/dsmapi/settings.properties".format(name)
        if os.path.isfile(settsf):
            shutil.move(settsf, "{}/src/main/resources/settings.properties".format(name))

        persf = "{}/src/main/resources/META-INF/persistence.xml".format(name)
        with open(persf) as f:
            text = f.read()
            text = fix_persistence(text)

        with open(persf, "w") as f:
            f.write(text)


def generate_mysql_url(db):
    return "jdbc:mysql://{}:{}/{}".format(DBHOST, DBPORT, db)


# asadmin create-jdbc-connection-pool --restype java.sql.Driver --driverclassname com.mysql.jdbc.Driver --property 'user=<user>:password=<pwd>:URL="<url>"' <name>
def pool(name, user, pwd, url):
    print("Create pool {}".format(name))
    asadmin("create-jdbc-connection-pool",
            "--restype",
            "java.sql.Driver",
            "--driverclassname",
            "com.mysql.jdbc.Driver",
            "--property",
            "user={}:password={}:URL={}".format(user, pwd, url.replace(":", "\:")),
            name)
    print("Pool created")


@cli.command("pools")
def createpools():
    for api in APIS:
        pool(api.get("bbdd"), DBUSER, DBPWD, generate_mysql_url(api.get("bbdd")))


# asadmin create-jdbc-resource --connectionpoolid <poolname> <jndiname>
def resource(name, pool):
    asadmin("create-jdbc-resource", "--connectionpoolid", pool, name)


@cli.command("resources")
def createresources():
    for api in APIS:
        url = api.get("url")
        pool = url.split("/")[-1][:-4]
        print("Create resource {}".format(pool))
        resource(api.get("resourcename"), pool)
        print("Resource created!")


def get_apis_default(dirs, default):
    if len(dirs) == 0:
        return default
    return [x for x in default if x.get("url").split("/")[-1][:-4] in dirs]


# asadmin deploy --contextroot <root> --name <root> <WAR.war>
def deploy(war, root, force=False):
    asadmin("deploy", "--force", "true" if force else "false", "--contextroot", root, "--name", root, war)


@cli.command("redeploy")
@click.option('--directory', "-d", multiple=True)
def redeployall(directory):
    print("Redeploying")
    # Check if the RSS configuration file exists
    if isfile("/etc/default/rss/database.properties"):
        rm("/etc/default/rss/database.properties")

    cp(rss.get("url").split("/")[-1][:-4] + "/properties/database.properties", "/etc/default/rss/database.properties")

    # Setting RSS database configuration
    with open("/etc/default/rss/database.properties") as f:
        text = f.read()

        text = text.replace("database.url=jdbc:mysql://localhost:3306/RSS", "database.url=jdbc:mysql://{}:{}/{}".format(DBHOST, DBPORT, rss.get('bbdd')))\
            .replace("database.username=root", "database.username={}".format(DBUSER))\
            .replace("database.password=root", "database.password={}".format(DBPWD))

    with open("/etc/default/rss/database.properties", "w+") as f:
        f.write(text)

    if not isfile("/etc/default/rss/oauth.properties"):
        cp(rss.get("url").split("/")[-1][:-4] + "/properties/oauth.properties", "/etc/default/rss/oauth.properties")

    for api in get_apis_default(directory, APIS + [rss]):
        url = api.get("url")
        name = url.split("/")[-1][:-4]
        print("cd {}".format(name))
        cd(name)
        print("Redeploy {}".format(api.get("war")))
        deploy(api.get("war"), api.get("root"), True)
        print("End deploy")
        cd("..")


@cli.command("charging")
@click.pass_context
def chargingbackend(ctx):
    print("Installing charging backend")
    name = charg.get("url").split("/")[-1][:-4]
    cd(name)

    if not os.path.isdir('virtenv'):
        virtualenv("virtenv")

    bash("python-dep-install.sh")

    cd('src')

    if not os.path.isdir('media'):
        mkdir('media')
        cd('media')
        mkdir('assets')
        mkdir('bills')
        cd("..")

    cd("..")
    cd("..")


def generate_endpoints(port, cport):
    template = "'{}': {{ 'path': '{}', 'port': '{}', 'host': 'localhost', 'appSsl': false }}, "
    base = [template.format(x.get("name"), x.get("root"), port) for x in APIS + [rss]]
    base.append("'management': { 'path': 'management', 'host': 'localhost', 'port': config.port, 'appSsl': config.https.enabled },")

    return ["config.endpoints = {\n"] + base + [template.format("charging", "charging", cport)] + ["};"]


@cli.command("proxy")
@click.option("--host", "-h", default="localhost", type=str)
@click.option("--port", "-p", default=8004, type=int)
@click.option("--chargingport", "-c", default=8006, type=int)
@click.option("--glassfishport", "-P", default=8080, type=int)
def proxyCommand(host, port, chargingport, glassfishport):
    print("Installing logic proxy")
    name = proxy.get("url").split("/")[-1][:-4]
    cd(name)
    bash('install.sh')
    if not os.path.isfile("config.js"):
        shutil.copy2("config.js.template", "config.js")

        with open("config.js") as f:
            text = f.read()

        text = text.replace("config.port = 80", "config.port = {}".format(port))\
                   .replace("'/proxy'", "''")

        texts = text.split("\n")
        texts = texts[:59] + generate_endpoints(glassfishport, chargingport) + texts[121:]

        text = "\n".join(texts)

        with open("config.js", "w") as f:
            f.write(text)

    if os.path.isdir('indexes'):
        rm('-rf', 'indexes')

    mkdir('indexes')
    node('fill_indexes.js')

    print("""
    Finished!
    Now, go to your IdM instance (e.g. https://account.lab.fiware.org) and create an application with this settings:

    - URL: http://{host}:{port}
    - Callback URL: http://{host}:{port}/auth/fiware/callback

    Create a role called "seller"
    Attach the role to the users you prefer.
    Modify config.js file with:

    - config.oauth2.clientID: The client ID that you got when you created the Application
    - config.oauth2.clientSecret: The client Secret that you got when you created the Application
    - config.oauth2.callbackURL = http://{host}:{port}/auth/fiware/callback

    Please refer to http://business-api-ecosystem.readthedocs.io/en/latest/installation-administration-guide.html#configuration
    for details on configuration settings
    """.format(host=host, port=port))


def _download_module(name, directory, branch):
    print("Downloading {} version {}".format(name, branch))
    cd(directory)

    git('stash')
    git('fetch')
    git('checkout', branch)
    git('pull', 'origin', branch)

    try:
        git('stash', 'pop')
    except:
        pass

    cd('..')


@cli.command("download")
def download():
    # Download new APIs software version
    for api in APIS:
        _download_module(api['name'], api['url'].split("/")[-1][:-4], api['branch'])

    _download_module('rss', rss['url'].split("/")[-1][:-4], rss['branch'])
    _download_module('charging', charg['url'].split("/")[-1][:-4], charg['branch'])
    _download_module('proxy', proxy['url'].split("/")[-1][:-4], proxy['branch'])


def _process_ids(ids, offering_id):
    # Check if the ids are referring to a product or offering
    if len(ids) == 2:
        return ['offering:{}'.format(ids[0]), 'product:{}'.format(ids[1])]

    # If there is only one Id it is needed to check in the catalog whether the id is an offering or a product
    conn = pymysql.connect(host=DBHOST, port=DBPORT, user=DBUSER, passwd=DBPWD, db=APIS[0]['bbdd'])
    cur = conn.cursor()

    cur.execute("SELECT IS_BUNDLE FROM CRI_PRODUCT_OFFERING WHERE ID='{}'".format(offering_id))
    res = cur.fetchone()[0]
    conn.close()

    prefix = 'product' if res == 0 else 'offering'

    return ['{}:{}'.format(prefix, ids[0])]


@cli.command("dump")
def dump():
    def save_api(api):
        print("Saving {} database...".format(api['name']))
        name = api['bbdd']
        dump_file = '/tmp/{}_dump.sql'.format(api['name'])
        mysqldump('-u', DBUSER, '-p{}'.format(DBPWD), '-h', DBHOST, '-P', DBPORT, name, _out=dump_file)

        print('File {} created'.format(dump_file))

    for api in APIS:
        save_api(api)

    save_api(rss)


@cli.command("migrate")
def migrate():
    print("Migrating from previous version")

    for api in APIS[0:3]:
        print("Migrating {} database...".format(api['name']))
        name = api['bbdd']
        dump_file_bk = '/tmp/{}_dump.sql'.format(api['name'])
        dump_file = '/tmp/{}_dump_cp.sql'.format(api['name'])

        cp(dump_file_bk, dump_file)

        sed('-i', "s|:([0123456789\.]*)||g", dump_file)

        mysql('-u', DBUSER, '-p{}'.format(DBPWD), '-h', DBHOST, '-P', DBPORT, '-e', "DROP DATABASE {}".format(name))
        mysql('-u', DBUSER, '-p{}'.format(DBPWD), '-h', DBHOST, '-P', DBPORT, '-e', "CREATE DATABASE {}".format(name))

        mysql('-u', DBUSER, '-p{}'.format(DBPWD), '-h', DBHOST, '-P', DBPORT, name, '-e', "source {}".format(dump_file))

        if api['name'] == 'inventory':
            conn = pymysql.connect(host=DBHOST, port=DBPORT, user=DBUSER, passwd=DBPWD, db=api['bbdd'])
            cur = conn.cursor()
            cur.execute("select * from PRODUCT_CHARACTERISTIC")

            results = cur.fetchall()
            for res in results:
                sp_name = res[2].split(' ')

                cur.execute(
                    "SELECT PRODUCT_OFFERING.ID FROM PRODUCT INNER JOIN PRODUCT_OFFERING ON PRODUCT.PRODUCT_OFFERING_PRODUCT_HJID=PRODUCT_OFFERING.HJID WHERE PRODUCT.ID={}".format(res[4]))

                off_id = cur.fetchone()[0]
                new_ids = None
                if (res[2].lower().endswith('asset type') or res[2].lower().endswith('media type')) and len(sp_name) > 2:
                    new_ids = _process_ids(sp_name[0:-2], off_id)
                    name = '{} {}'.format(sp_name[-2], sp_name[-1])

                elif res[2].lower().endswith('location') and len(sp_name) > 1:
                    new_ids = _process_ids(sp_name[0:-1], off_id)
                    name = sp_name[-1]

                if new_ids is not None:
                    # Update characteristic name
                    new_name = ' '.join(new_ids)
                    new_name = new_name + ' ' + name

                    cur.execute("UPDATE PRODUCT_CHARACTERISTIC SET NAME_ = '{}' WHERE HJID={}".format(new_name, res[0]))

            conn.commit()
            conn.close()

        print("Database {} migrated".format(api['name']))


@cli.command("upgrade")
@click.pass_context
def upgrade(ctx):
    print("Upgrading from version 5.4.1 to 7.4.0")
    ctx.invoke(download)
    ctx.invoke(maveninstall)

    ctx.invoke(dump)
    ctx.invoke(redeployall, directory=tuple())

    ctx.invoke(migrate)
    ctx.invoke(chargingbackend)
    ctx.invoke(proxyCommand)


@cli.command("all")
@click.pass_context
def doall(ctx):
    ctx.invoke(clone)
    ctx.invoke(modify_persistence)
    ctx.invoke(maveninstall)
    ctx.invoke(createtables)
    ctx.invoke(createpools)
    ctx.invoke(createresources)
    ctx.invoke(redeployall, directory=tuple())
    print("All APIs are deployed in glassfish")

    ctx.invoke(chargingbackend)
    ctx.invoke(proxyCommand)


if __name__ == "__main__":
    cli()
