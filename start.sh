#!/bin/sh

set -e 

echo "run db migration" 
/app/migration  -path/app/migration -database "$ DB_URL" -varbose up 
 echo "start the app"
 exec "$@" 