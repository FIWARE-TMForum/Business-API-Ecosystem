# Business API Ecosystem Docker Image

Starting on version 5.4.0, you are able to run the [Business API Ecosystem](https://github.com/FIWARE-TMForum/Business-API-Ecosystem) with Docker. The Business API Ecosystem requires an instance of MySQL running. In this regard, you have three possibilities:
* You can have your own MySQL instance deployed in your machine
* You can manually run a docker image of MySQL before executing the Business API Ecosystem
* You can use docker-compose to automatically deploy both components

You can build a docker image based on this Dockerfile. This image will contain only an instance of the Business API Ecosystem, exposing port `8000`. This requires that you have [docker](https://docs.docker.com/installation/) installed on your machine.

If you just want to have a Business Ecosystem Logic Proxy instance running as quickly as possible jump to section *The Fastest Way*.

If you want to know what is behind the scenes of our container you can go ahead and read the build section.

## OAuth2 Authentication

The Business API Ecosystem authenticates with the [FIWARE Lab identity manager](https://account.lab.fiware.org). In this regard, it is needed to register an application in this portal in order to acquire the OAuth2 credentials.

There you have to use the following info for registering the app:
* Name: The name you want for your instance
* URL: Host and port where you plan to run the instance. http|https://host:port/
* Callback URL: URL to be called in the OAuth process. http|https://host:port/auth/fiware/callback

## The Fastest Way

As stated before, the Business API Ecosystem requires a MySQL instance running. You can deploy everything automatically if you have `docker-compose`
installed. To do so, you must create a folder to place a new file file called `docker-compose.yml` that should include the following content:

```

biz_db:
    image: mysql:latest
    ports:
        - "3333:3306"
    volumes:
        - /var/lib/mysql
    environment:
        - MYSQL_ROOT_PASSWORD=my-secret-pw

biz_ecosystem:
    image: conwetlab/business-api-ecosystem
    ports:
        - "8000:8000"
    links:
        - biz_db
    volumes:
        - /your/route/to/media:/apis/business-ecosystem-charging-backend/src/media    
    environment:
        - MYSQL_ROOT_PASSWORD=my-secret-pw
        - MYSQL_HOST=biz_db
        - OAUTH2_CLIENT_ID=your-client-id
        - OAUTH2_CLIENT_SECRET=your-client-secret
        - PAYPAL_CLIENT_ID=your-paypal-client-id
        - PAYPAL_CLIENT_SECRET=your-paypal-client-secret
        - ADMIN_EMAIL=your@email.com
        - BIZ_ECOSYS_PORT=your-port
        - BIZ_ECOSYS_HOST=your-host

```
Additionally, you can run the containers manually using the following commands:

```
sudo docker run --name biz_db -e MYSQL_ROOT_PASSWORD=my-secret-pw -p PORT:3306 -v /var/lib/mysql -d mysql
```

To Business API Ecosystem:

```
sudo docker run -e MYSQL_ROOT_PASSWORD=my-secret-pw -e MYSQL_HOST=rss_db -e OAUTH2_CLIENT_ID=your-oauth-client-id -e OAUTH2_CLIENT_SECRET=your-oauth-client-secret -e BIZ_ECOSYS_PORT=your-port -e BIZ_ECOSYS_HOST=your-host -e PAYPAL_CLIENT_ID=your-paypal-client-id -e PAYPAL_CLIENT_SECRET=your-paypal-client-secret -e ADMIN_EMAIL=your@email.com -p your-port:8000 --link biz_db conwetlab/business-api-ecosystem
```

Note in the previous commands, that it is needed to provide some environment variables. Concretely:

* **MYSQL_ROOT_PASSWORD**: Password of the MySQL root user 
* **MYSQL_HOST**: Host of MySQL. If you are linking instances this value will be the name of the MySQL container
* **OAUTH2_CLIENT_ID**: Client id given by the FIWARE IdM for the application
* **OAUTH2_CLIENT_SECRET**: Client secret given by the FIWARE IdM for the application
* **PAYPAL_CLIENT_ID**: Client id given by PayPal for the application in order to charge customers (Sanbox accounts are allowed)
* **PAYPAL_CLIENT_SECRET**: Client secret given by PayPal for the application in order to charge customers (Sanbox accounts are allowed)
* **ADMIN_EMAIL**: Valid email required for administration
* **BIZ_ECOSYS_PORT**: Port where the Business API Ecosystem is going to run
* **BIZ_ECOSYS_HOST**: Host where the Business API Ecosystem is going to run

## Build the image

If you have downloaded the [Business API Ecosystem](https://github.com/FIWARE-TMForum/Business-API-Ecosystem) you can 
build your own image. The end result will be the same, but this way you have a bit more of control of what's happening.

To create the image, just navigate to the `docker` directory and run:

    sudo docker build -t business-api-ecosystem .

> **Note**
> If you do not want to have to use `sudo` in this or in the next section follow [these instructions](http://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo).


The parameter `-t business-api-ecosystem` gives the image a name. This name could be anything, or even include an organization like `-t conwetlab/biz-ecosystem-logic-proxy`. This name is later used to run the container based on the image.

If you want to know more about images and the building process you can find it in [Docker's documentation](https://docs.docker.com/userguide/dockerimages/).
