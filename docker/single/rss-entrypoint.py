#!/usr/bin/env python
# Credits of this code to @Rock_Neurotiko

from os import getenv
import time, socket
from sh import asadmin, cat, cd

rss = {
    "war": "./fiware-rss/target/DSRevenueSharing.war",
    "root": "DSRevenueSharing"
}

DBUSER = "root"
DBPWD = getenv("MYSQL_ROOT_PASSWORD", "toor")
DBHOST = getenv("MYSQL_HOST", "localhost")
DBPORT = "3306"

text = ""
with open("/etc/default/rss/database.properties") as f:
    text = f.read()
    text = text.replace("database.url=jdbc:mysql://localhost:3306/RSS", "database.url=jdbc:mysql://{}:{}/RSS".format(DBHOST, DBPORT))\
        .replace("database.username=root", "database.username={}".format(DBUSER))\
        .replace("database.password=root", "database.password={}".format(DBPWD))

with open("/etc/default/rss/database.properties", "w+") as f:
    f.write(text)

for i in range(20):
    try:
        time.sleep(1)
        print("Trying to connect to the database:.... ")
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect((DBHOST, int(DBPORT)))
        sock.close()
        print("Successfully connected")
        break
    except:
        continue

cd('business-ecosystem-rss')

print("\nstarted\n")
asadmin("deploy", "--force", "false", "--contextroot", rss.get('root'), "--name", rss.get('root'), rss.get('war'))

cd('..')
