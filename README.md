
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Kafka Replication Factor Violation.
---

This incident type refers to a situation where the replication factor of a Kafka cluster falls below the required threshold. Replication factor determines how many copies of a message are stored across the Kafka cluster to ensure data durability and fault tolerance. When the replication factor falls below the required level, it can lead to data loss, inconsistencies, and other issues. This incident requires immediate attention and resolution to prevent any further damage.

### Parameters
```shell 
export TOPIC_NAME="PLACEHOLDER"

export ZOOKEEPER_PORT="PLACEHOLDER"

export ZOOKEEPER_HOSTNAME="PLACEHOLDER"

export KAFKA_BOOTSTRAP_SERVER="PLACEHOLDER"

export ZOOKEEPER_CONNECTION_STRING="PLACEHOLDER"


```

## Debug

### Check the replication factor of a topic
```shell
kafka-topics --zookeeper ${ZOOKEEPER_HOSTNAME}:${ZOOKEEPER_PORT} --describe --topic ${TOPIC_NAME}
```

### Check the ISR (In-Sync Replicas) of all brokers for a topic
```shell
kafka-topics --zookeeper ${ZOOKEEPER_HOSTNAME}:${ZOOKEEPER_PORT} --describe --topic ${TOPIC_NAME} | grep -E '^ISR'
```

### Check the status of all brokers in the Kafka cluster
```shell
kafka-broker-api-versions --bootstrap-server ${KAFKA_BOOTSTRAP_SERVER}
```

### Check the leader status of a partition for a topic
```shell
kafka-topics --zookeeper ${ZOOKEEPER_HOSTNAME}:${ZOOKEEPER_PORT} --describe --topic ${TOPIC_NAME} | grep -E '^Leader'
```

### Check the number of partitions for a topic
```shell
kafka-topics --zookeeper ${ZOOKEEPER_HOSTNAME}:${ZOOKEEPER_PORT} --describe --topic ${TOPIC_NAME} | grep -E '^PartitionCount'
```

## Repair

### Increase replication factor: The first step in resolving this incident is to increase the replication factor of the Kafka cluster to the required level. This can be done by adding new brokers to the cluster or reconfiguring the existing brokers to handle more replicas.
```shell


#!/bin/bash



# Set variables

KAFKA_HOME=${PATH_TO_KAFKA_HOME}

REPLICATION_FACTOR=${DESIRED_REPLICATION_FACTOR}

ZOOKEEPER_CONNECT=${ZOOKEEPER_CONNECTION_STRING}



# Increase replication factor

$KAFKA_HOME/bin/kafka-topics.sh --zookeeper $ZOOKEEPER_CONNECT --alter --topic ${TOPIC_NAME} --partitions ${NUM_PARTITIONS} --replication-factor $REPLICATION_FACTOR



echo "Replication factor increased to $REPLICATION_FACTOR for topic ${TOPIC_NAME}"


```