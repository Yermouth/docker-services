#!/bin/bash

perl -i -pe 's/^\s*(ulimit.*|set_shmall|set_shmmax)\s*$/#$1/' /etc/init.d/aerospike
service aerospike start && perl -e 'while(`grep "service ready" /var/log/aerospike/aerospike.log` =~ /^$/) {sleep 1}'
# set up secondary index
aql -c "CREATE INDEX d2-b-hmac ON d2.b (hmac) STRING"
aql -c "CREATE INDEX d2-d-hwid ON d2.d (hardware_id) STRING"
