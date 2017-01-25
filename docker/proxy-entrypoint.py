#!/usr/bin/env python
from os import getenv
from pymongo import MongoClient
import sys
import time

port = {'matchport': "config.port = 80;",
        'port': "config.port = {};".format("8000")}

prefix = {'matchprefix': "config.proxyPrefix = '/proxy';",
          'prefix': 'config.proxyPrefix = ""'}

text = ""
with open("./config.js") as f:
    text = f.read()


text = text.replace(port.get('matchport'), port.get('port'))
text = text.replace(prefix.get('matchprefix'), prefix.get('prefix'))

text = text.replace("'clientSecret': '--client-secret--',",
                    "'clientSecret': '{}',".format(getenv("OAUTH2_CLIENT_SECRET")))

text = text.replace("'clientID': '--client-id--',",
                    "'clientID': '{}',".format(getenv("OAUTH2_CLIENT_ID")))

text = text.replace("'callbackURL': 'http://localhost/auth/fiware/callback',",
                    "'callbackURL': 'http://{}:{}/auth/fiware/callback',".format(getenv("BIZ_ECOSYS_HOST"), getenv("BIZ_ECOSYS_PORT")))

with open("./config.js", "w+") as f:
    f.write(text)

