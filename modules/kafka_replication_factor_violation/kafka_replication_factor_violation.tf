resource "shoreline_notebook" "kafka_replication_factor_violation" {
  name       = "kafka_replication_factor_violation"
  data       = file("${path.module}/data/kafka_replication_factor_violation.json")
  depends_on = [shoreline_action.invoke_increase_replication]
}

resource "shoreline_file" "increase_replication" {
  name             = "increase_replication"
  input_file       = "${path.module}/data/increase_replication.sh"
  md5              = filemd5("${path.module}/data/increase_replication.sh")
  description      = "Increase replication factor: The first step in resolving this incident is to increase the replication factor of the Kafka cluster to the required level. This can be done by adding new brokers to the cluster or reconfiguring the existing brokers to handle more replicas."
  destination_path = "/tmp/increase_replication.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_increase_replication" {
  name        = "invoke_increase_replication"
  description = "Increase replication factor: The first step in resolving this incident is to increase the replication factor of the Kafka cluster to the required level. This can be done by adding new brokers to the cluster or reconfiguring the existing brokers to handle more replicas."
  command     = "`chmod +x /tmp/increase_replication.sh && /tmp/increase_replication.sh`"
  params      = ["TOPIC_NAME","ZOOKEEPER_CONNECTION_STRING"]
  file_deps   = ["increase_replication"]
  enabled     = true
  depends_on  = [shoreline_file.increase_replication]
}

