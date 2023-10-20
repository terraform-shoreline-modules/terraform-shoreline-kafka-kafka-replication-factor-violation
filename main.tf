terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "kafka_replication_factor_violation" {
  source    = "./modules/kafka_replication_factor_violation"

  providers = {
    shoreline = shoreline
  }
}