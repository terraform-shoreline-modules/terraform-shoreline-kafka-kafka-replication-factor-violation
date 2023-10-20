

#!/bin/bash



# Set variables

KAFKA_HOME=${PATH_TO_KAFKA_HOME}

REPLICATION_FACTOR=${DESIRED_REPLICATION_FACTOR}

ZOOKEEPER_CONNECT=${ZOOKEEPER_CONNECTION_STRING}



# Increase replication factor

$KAFKA_HOME/bin/kafka-topics.sh --zookeeper $ZOOKEEPER_CONNECT --alter --topic ${TOPIC_NAME} --partitions ${NUM_PARTITIONS} --replication-factor $REPLICATION_FACTOR



echo "Replication factor increased to $REPLICATION_FACTOR for topic ${TOPIC_NAME}"