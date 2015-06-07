#!/bin/bash

KAFKA_HOME=/opt/kafka_2.8.0-0.8.1.1

nohup /usr/bin/start-aerospike.sh &

if [[ $1 == "-bash" ]]; then
  nohup /usr/bin/start-zookeeper.sh &
  nohup /usr/bin/start-kafka.sh &
  /bin/bash
else
  supervisord
fi
