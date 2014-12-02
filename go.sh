#!/bin/bash
if [ ! -f /.auth_setup_already ]; then
	/auth.sh
fi

if [ "$AUTH" == "yes" ]; then
    export mongodb='mongod --nojournal --auth --httpinterface --rest'
else
    export mongodb='mongod --nojournal --httpinterface --rest'
fi

if [ ! -f /data/db/mongod.lock ]; then
    eval $mongodb
else
    export mongodb=$mongodb' --dbpath /data/db'
    rm /data/db/mongod.lock
    mongod --dbpath /data/db --repair && eval $mongodb
fi
