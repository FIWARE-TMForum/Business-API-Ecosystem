FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y --fix-missing python2.7 python-pip git wget unzip maven mysql-client openjdk-8-jdk

# Download and install glassfish
RUN wget http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip
RUN unzip glassfish-4.1.zip

RUN pip install sh

# Download the mysql connector and place it in the proper directory
RUN wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.39.tar.gz

RUN tar -xvf mysql-connector-java-5.1.39.tar.gz

RUN cp ./mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar glassfish4/glassfish/domains/domain1/lib

RUN mkdir /apis
WORKDIR /apis

RUN mkdir wars

RUN git clone https://github.com/FIWARE-TMForum/DSPRODUCTCATALOG2.git

WORKDIR DSPRODUCTCATALOG2

RUN git checkout v5.4.1

# Fixing reloading the database everytime the API is restarted
RUN sed -i 's/jdbc\/sample/jdbc\/pcatv2/g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<provider>org\.eclipse\.persistence\.jpa\.PersistenceProvider<\/provider>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.ddl-generation" value="drop-and-create-tables"\/>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.logging\.level" value="FINE"\/>/ /g' ./src/main/resources/META-INF/persistence.xml

RUN if [ -f "./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties" ]; then mv ./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties ./DSPRODUCTORDERING/src/main/resources/settings.properties; fi

# Add condition if not present in properties. This was as pain to write as it is to read
RUN grep -F "<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"/>" ./src/main/resources/META-INF/persistence.xml || sed -i 's/<\/properties>/\t<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"\/>\n\t\t<\/properties>/g' ./src/main/resources/META-INF/persistence.xml

# Create WAR file
RUN mvn install

RUN mv ./target/DSProductCatalog.war ../wars/

WORKDIR ../

# Next api Docker
RUN git clone https://github.com/FIWARE-TMForum/DSPRODUCTORDERING.git

WORKDIR DSPRODUCTORDERING

RUN git checkout v5.4.1

# Fixing reloading the database everytime the API is restarted
RUN sed -i 's/jdbc\/sample/jdbc\/podbv2/g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<provider>org\.eclipse\.persistence\.jpa\.PersistenceProvider<\/provider>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.ddl-generation" value="drop-and-create-tables"\/>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.logging\.level" value="FINE"\/>/ /g' ./src/main/resources/META-INF/persistence.xml

RUN if [ -f "./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties" ]; then mv ./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties ./DSPRODUCTORDERING/src/main/resources/settings.properties; fi

# Add condition if not present in properties. This was as pain to write as it is to read
RUN grep -F "<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"/>" ./src/main/resources/META-INF/persistence.xml || sed -i 's/<\/properties>/\t<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"\/>\n\t\t<\/properties>/g' ./src/main/resources/META-INF/persistence.xml

# Create WAR file
RUN mvn install

RUN mv ./target/DSProductOrdering.war ../wars/

WORKDIR ../

# Next api Docker
RUN git clone https://github.com/FIWARE-TMForum/DSPRODUCTINVENTORY.git

WORKDIR DSPRODUCTINVENTORY

RUN git checkout v5.4.1

# Fixing reloading the database everytime the API is restarted
RUN sed -i 's/jdbc\/sample/jdbc\/pidbv2/g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<provider>org\.eclipse\.persistence\.jpa\.PersistenceProvider<\/provider>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.ddl-generation" value="drop-and-create-tables"\/>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.logging\.level" value="FINE"\/>/ /g' ./src/main/resources/META-INF/persistence.xml

RUN if [ -f "./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties" ]; then mv ./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties ./DSPRODUCTORDERING/src/main/resources/settings.properties; fi

# Add condition if not present in properties. This was as pain to write as it is to read
RUN grep -F "<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"/>" ./src/main/resources/META-INF/persistence.xml || sed -i 's/<\/properties>/\t<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"\/>\n\t\t<\/properties>/g' ./src/main/resources/META-INF/persistence.xml

# Create WAR file
RUN mvn install

RUN mv ./target/DSProductInventory.war ../wars/

WORKDIR ../

# Next api Docker
RUN git clone https://github.com/FIWARE-TMForum/DSPARTYMANAGEMENT.git

WORKDIR DSPARTYMANAGEMENT

RUN git checkout v5.4.1

# Fixing reloading the database everytime the API is restarted
RUN sed -i 's/jdbc\/sample/jdbc\/partydb/g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<provider>org\.eclipse\.persistence\.jpa\.PersistenceProvider<\/provider>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.ddl-generation" value="drop-and-create-tables"\/>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.logging\.level" value="FINE"\/>/ /g' ./src/main/resources/META-INF/persistence.xml

RUN if [ -f "./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties" ]; then mv ./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties ./DSPRODUCTORDERING/src/main/resources/settings.properties; fi

# Add condition if not present in properties. This was as pain to write as it is to read
RUN grep -F "<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"/>" ./src/main/resources/META-INF/persistence.xml || sed -i 's/<\/properties>/\t<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"\/>\n\t\t<\/properties>/g' ./src/main/resources/META-INF/persistence.xml

# Create WAR file
RUN mvn install

RUN mv ./target/DSPartyManagement.war ../wars/

WORKDIR ../

# Next api Docker
RUN git clone https://github.com/FIWARE-TMForum/DSBILLINGMANAGEMENT.git

WORKDIR DSBILLINGMANAGEMENT

RUN git checkout v5.4.1

# Fixing reloading the database everytime the API is restarted
RUN sed -i 's/jdbc\/sample/jdbc\/bmdbv2/g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<provider>org\.eclipse\.persistence\.jpa\.PersistenceProvider<\/provider>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.ddl-generation" value="drop-and-create-tables"\/>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.logging\.level" value="FINE"\/>/ /g' ./src/main/resources/META-INF/persistence.xml

RUN if [ -f "./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties" ]; then mv ./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties ./DSPRODUCTORDERING/src/main/resources/settings.properties; fi

# Add condition if not present in properties. This was as pain to write as it is to read
RUN grep -F "<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"/>" ./src/main/resources/META-INF/persistence.xml || sed -i 's/<\/properties>/\t<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"\/>\n\t\t<\/properties>/g' ./src/main/resources/META-INF/persistence.xml

# Create WAR file
RUN mvn install

RUN mv ./target/DSBillingManagement.war ../wars/

WORKDIR ../

# Next api Docker
RUN git clone https://github.com/FIWARE-TMForum/DSCUSTOMER.git

WORKDIR DSCUSTOMER

RUN git checkout v5.4.1

# Fixing reloading the database everytime the API is restarted
RUN sed -i 's/jdbc\/sample/jdbc\/customerdbv2/g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<provider>org\.eclipse\.persistence\.jpa\.PersistenceProvider<\/provider>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.ddl-generation" value="drop-and-create-tables"\/>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.logging\.level" value="FINE"\/>/ /g' ./src/main/resources/META-INF/persistence.xml

RUN if [ -f "./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties" ]; then mv ./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties ./DSPRODUCTORDERING/src/main/resources/settings.properties; fi

# Add condition if not present in properties. This was as pain to write as it is to read
RUN grep -F "<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"/>" ./src/main/resources/META-INF/persistence.xml || sed -i 's/<\/properties>/\t<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"\/>\n\t\t<\/properties>/g' ./src/main/resources/META-INF/persistence.xml

# Create WAR file
RUN mvn install

RUN mv ./target/DSCustomerManagement.war ../wars/

WORKDIR ../

# Next api Docker
RUN git clone https://github.com/FIWARE-TMForum/DSUSAGEMANAGEMENT.git

WORKDIR DSUSAGEMANAGEMENT

RUN git checkout v5.4.1

# Fixing reloading the database everytime the API is restarted
RUN sed -i 's/jdbc\/sample/jdbc\/usagedbv2/g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<provider>org\.eclipse\.persistence\.jpa\.PersistenceProvider<\/provider>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.ddl-generation" value="drop-and-create-tables"\/>/ /g' ./src/main/resources/META-INF/persistence.xml
RUN sed -i 's/<property name="eclipselink\.logging\.level" value="FINE"\/>/ /g' ./src/main/resources/META-INF/persistence.xml

RUN if [ -f "./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties" ]; then mv ./DSPRODUCTORDERING/src/main/java/org/tmf/dsmapi/settings.properties ./DSPRODUCTORDERING/src/main/resources/settings.properties; fi

# Add condition if not present in properties. This was as pain to write as it is to read
RUN grep -F "<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"/>" ./src/main/resources/META-INF/persistence.xml || sed -i 's/<\/properties>/\t<property name=\"javax.persistence.schema-generation.database.action\" value=\"drop-and-create\"\/>\n\t\t<\/properties>/g' ./src/main/resources/META-INF/persistence.xml

# Create WAR file
RUN mvn install

RUN mv ./target/DSUsageManagement.war ../wars/

WORKDIR ../

# Compile RSS
RUN git clone https://github.com/FIWARE-TMForum/business-ecosystem-rss.git

WORKDIR business-ecosystem-rss

RUN git checkout v5.4.1

# Create WAR file

RUN mvn install -DskipTests

RUN mkdir /etc/default/rss/

COPY database.properties /etc/default/rss/database.properties

COPY oauth.properties /etc/default/rss/oauth.properties


WORKDIR ../

# Deploy charging backend

RUN apt-get update
RUN apt-get install -y --fix-missing gcc mongodb wkhtmltopdf xvfb python-dev build-essential libssl-dev libffi-dev apache2 libapache2-mod-wsgi

RUN git clone https://github.com/FIWARE-TMForum/business-ecosystem-charging-backend.git

WORKDIR business-ecosystem-charging-backend

RUN git checkout v5.4.1

# Create required folders
RUN mkdir -p /data/db/
RUN mkdir ./src/media
RUN mkdir ./src/media/bills
RUN mkdir ./src/media/assets
RUN mkdir ./src/plugins

ENV WORKSPACE=`pwd`

RUN ./python-dep-install.sh

# Create volumes
VOLUME /data/db
VOLUME /apis/business-ecosystem-charging-backend/src/media/bills
VOLUME /apis/business-ecosystem-charging-backend/src/media/assets
VOLUME /apis/business-ecosystem-charging-backend/src/plugins

WORKDIR src

RUN rm wsgi.py
COPY wsgi.py .

WORKDIR /etc/apache2/
COPY charging.conf ./sites-available

RUN ln -s ../sites-available/charging.conf ./sites-enabled/charging.conf
RUN sed -i "s|Listen 80|Listen 8006|g" ports.conf

WORKDIR /apis

# Deploy logic proxy

RUN git clone https://github.com/FIWARE-TMForum/business-ecosystem-logic-proxy

WORKDIR /

RUN wget https://nodejs.org/dist/v6.9.1/node-v6.9.1-linux-x64.tar.xz

RUN tar -xvf node-v6.9.1-linux-x64.tar.xz

RUN echo 'export PATH=$PATH:/node-v6.9.1-linux-x64/bin' >> ~/.bashrc

WORKDIR /apis/business-ecosystem-logic-proxy

RUN git checkout v5.4.1

RUN mkdir indexes
VOLUME /apis/business-ecosystem-logic-proxy/indexes

RUN export PATH=$PATH:/node-v6.9.1-linux-x64/bin; npm install

RUN cp config.js.template config.js

WORKDIR /apis

COPY ./entrypoint.sh /
COPY ./rss-entrypoint.py /
COPY ./proxy-entrypoint.py /
COPY ./apis-entrypoint.py /

EXPOSE 8000
ENTRYPOINT ["/entrypoint.sh"]

