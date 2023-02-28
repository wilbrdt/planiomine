#!/bin/bash

# Exit when a command fails
set -e

echo "Extract from zip and dispatch"
cd _input 
tar -xvf *.tar.gz 
mv attachments/* ../files
gzip -d database.sql.gz
mv database.sql ../sql
echo "Extract and dispatch successfully done"