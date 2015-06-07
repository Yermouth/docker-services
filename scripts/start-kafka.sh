#!/bin/bash

# Courtesy spotify/kafka
# 
# Optional ENV variables:
# * KAFKA_HOST: the external ip for the container, e.g. `boot2docker ip`
# * KAFKA_PORT: the external port for Kafka, e.g. 9092
# * ZK_CHROOT: the zookeeper chroot that's used by Kafka (without / prefix), e.g. "kafka"
# * LOG_RETENTION_HOURS: the minimum age of a log file in hours to be eligible for deletion (default is 168, for 1 week)
# * LOG_RETENTION_BYTES: configure the size at which segments are pruned from the log, (default is 1073741824, for 1GB)

# Set the external host and port
if [ ! -z "$KAFKA_HOST" ]; then
    echo "advertised host: $KAFKA_HOST"
    sed -r -i "s/#(advertised.host.name)=(.*)/\1=$KAFKA_HOST/g" $KAFKA_HOME/config/server.properties
fi
if [ ! -z "$KAFKA_PORT" ]; then
    echo "advertised port: $KAFKA_PORT"
    sed -r -i "s/#(advertised.port)=(.*)/\1=$KAFKA_PORT/g" $KAFKA_HOME/config/server.properties
fi

# Set the zookeeper chroot
if [ ! -z "$ZK_CHROOT" ]; then
    # configure kafka
    sed -r -i "s/(zookeeper.connect)=(.*)/\1=localhost:2181\/$ZK_CHROOT/g" $KAFKA_HOME/config/server.properties
fi

# Allow specification of log retention policies
if [ ! -z "$LOG_RETENTION_HOURS" ]; then
    echo "log retention hours: $LOG_RETENTION_HOURS"
    sed -r -i "s/(log.retention.hours)=(.*)/\1=$LOG_RETENTION_HOURS/g" $KAFKA_HOME/config/server.properties
fi
if [ ! -z "$LOG_RETENTION_BYTES" ]; then
    echo "log retention bytes: $LOG_RETENTION_BYTES"
    sed -r -i "s/#(log.retention.bytes)=(.*)/\1=$LOG_RETENTION_BYTES/g" $KAFKA_HOME/config/server.properties
fi

# Run Kafka
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
