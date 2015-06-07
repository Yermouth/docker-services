
FROM ubuntu:14.04
FROM java:openjdk-8-jre

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER lonex

# Install
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y wget && \
  apt-get install -y perl && \
  apt-get install -y vim && \
  apt-get install -y logrotate && \
  apt-get install -y supervisor && \
  rm -rf /var/lib/apt/lists/*

ENV KAFKA_PACKAGE kafka_2.8.0-0.8.1.1
ENV KAFKA_HOME /opt/kafka_2.8.0-0.8.1.1

# Kafka, zookeeper
RUN \
  wget -q http://apache.mirrors.spacedump.net/kafka/0.8.1.1/${KAFKA_PACKAGE}.tgz -O /tmp/${KAFKA_PACKAGE}.tgz && \
  tar zxvf /tmp/${KAFKA_PACKAGE}.tgz -C /opt && \
  rm /tmp/${KAFKA_PACKAGE}.tgz

# aerospike
RUN \
  wget -q http://aerospike.com/download/server/3.5.9/artifact/ubuntu12 -O /tmp/aerospike.tgz && \
  tar zxvf /tmp/aerospike.tgz -C /opt && \
  rm /tmp/aerospike.tgz && \
  cd /opt/aerospike-server-community-3.5.9-ubuntu12.04 && \
  ./asinstall && \
  cd -


ADD scripts/launch.sh /usr/bin/launch.sh
ADD scripts/start-zookeeper.sh /usr/bin/start-zookeeper.sh
ADD scripts/start-kafka.sh /usr/bin/start-kafka.sh
ADD scripts/start-aerospike.sh /usr/bin/start-aerospike.sh
ADD aerospike/aerospike.conf /etc/aerospike/aerospike.conf
ADD supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 2181 9092 3000 3001 3002 3003

CMD ["/usr/bin/launch.sh"]
