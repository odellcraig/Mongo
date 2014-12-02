mongodb
====================

Base docker image to run a MongoDB database server

Usage
-----

To create the image `odellcraig/mongodb`:

        docker build -t odellcraig/mongodb .


Running the MongoDB server
--------------------------

Run the following command to start MongoDB:

        docker run -d -p 27017:27017 -p 28017:28017 --name mongodb odellcraig/mongodb

The first time that you run your container, a new random password will be set.
To get the password, check the logs of the container by running:

        docker logs <CONTAINER_ID>


In this case, `5elsT6KtjrqV` is the password set.
You can then connect to MongoDB:

         mongo admin -u admin -p 5elsT6KtjrqV
         URI: mongodb://admin:5elsT6KtjrqV/<host>:<port>/<database>

Done!

Setting a specific password for the admin account
-------------------------------------------------

If you want to use a preset password instead of a randomly generated one, you can
set the environment variable `MONGODB_PASS` to your specific password when running the container:

        docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_PASS="mypass" --name mongodb odellcraig/mongodb

You can now test your new admin password:

        mongo admin -u admin -p mypass
        curl --user admin:mypass --digest http://localhost:28017/

Run MongoDB without password
----------------------------

If you want run MongoDB without password you can set tge environment variable `AUTH` to specific if you want password or not when running the container:

        docker run -d -p 27017:27017 -p 28017:28017 -e AUTH=no  --name mongodb odellcraig/mongodb

By default is "yes".

Cite: https://github.com/tutumcloud/tutum-docker-mongodb
