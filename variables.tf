variable "instance_type" {
  type = string
  default = "t2.small.elasticsearch"
  description = "To remain in AWS free tier, selecting t2.small instance"
}

variable "instance_count" {
  type = number
  default = "3"
  description = "As mentioned in Problem Statement, Creating cluster of 3 ElasticSearch Nodes "
}

variable "dedicated_master_enabled" {
  type = bool
  default = "false"
  description = "Keeping it false, as it require atleast 3 nodes by default"
}

variable "ebs_enabled" {
  type = bool
  default = "true"
}

variable "encrypt_at_rest" {
  type = bool
  default = "false"
  description = "t2.small.elasticsearch does not support encryption at rest. For other instance better option to keep it true for more security"
}


variable "node_to_node_encryption" {
  type = bool
  default = "true"
  description = "Provides an additional layer of security, enable TLS encryption for all communication within VPC"
}

variable "source_ip" {}

variable "log_type_search" {
  default = "SEARCH_SLOW_LOGS"
  description = "publishing search cloudwatch log"
}


variable "log_type_index" {
  default = "INDEX_SLOW_LOGS"
  description = "Publishing index cloudwatch log"
}

variable "subnet" {}
