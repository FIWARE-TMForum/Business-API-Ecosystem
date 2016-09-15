#!/usr/bin/env python
# Contributed by @Cazaril

from os import getenv, system
from pymongo import MongoClient
import sys
import time

# Connect to mongodb
connection = MongoClient(connect=False)

# use wstore_context
db = connection['wstore_db']

connected = False
i = 0

while not connected and i < 20:
    try:
        print("\nTesting connection to mongodb\n")
        time.sleep(0.5)
        i += 1
        dbNames = db.collection_names()
        connected = True
        print("\nConnection correct\n")
    except:
        pass

if not connected:
    print("Can't stablish connection to mongodb\n")
    sys.exit()

try:
    if "site" not in dbNames:
        print("\nCreating external site\n")
        system("/business-ecosystem-charging-backend/src/manage.py createsite external {}:{}".format(getenv("BIZ_ECOSYS_HOST"), getenv("BIZ_ECOSYS_PORT")))
except:
    print("ERROR CREATESITE EXTERNAL")
    sys.exit()

try:
    if "local_site" not in db.collection_names():
        print("\nCreating localsite site\n")
        system("/business-ecosystem-charging-backend/src/manage.py createsite internal http://127.0.0.1:8004")
except:
    print("ERROR CREATESITE INTERNAL")
    sys.exit()
