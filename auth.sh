#!/bin/bash

if [ -f /.auth_setup_already ]; then
	echo "MongoDB password already set!"
	exit 0
fi

mongod --smallfiles --nojournal &

PASS=${MONGODB_PASS:-$(pwgen -s 15 1)}
_word=$( [ ${MONGODB_PASS} ] && echo "preset" || echo "random" )

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

echo "=> Creating an admin user with a ${_word} password in MongoDB"
mongo admin --eval "db.createUser({user: 'admin', pwd: '$PASS', roles: [ 'root' ]});"
mongo halo --eval "db.createUser({user: 'admin', pwd: '$PASS', roles: [ 'dbOwner' ]});"
mongo remember --eval "db.createUser({user: 'admin', pwd: '$PASS', roles: [ 'dbOwner' ]});"
mongo admin --eval "db.shutdownServer();"

echo "=> Done!"
touch /.mongodb_password_set

echo "========================================================================"
echo "You can now connect to this MongoDB server using:"
echo ""
echo "    mongo admin -u admin -p $PASS --host <host> --port <port>"
echo "    URI:"
echo "    mongodb://admin:$PASS@<host>:<port>/<database>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
