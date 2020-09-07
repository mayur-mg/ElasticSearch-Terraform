provider "aws" {
    region = "us-west-2"
}

data "aws_caller_identity" "my_account" {}
data "aws_vpc" "vpc_based_es" {}


resource "aws_security_group" "es_sg" {
    name = "ElasticSearch SG"
    description = "ElasticSearch secure communication, HTTPS port only"

    ingress {
        from_port = 443
        protocol = "tcp"
        to_port = 443
        cidr_blocks = [data.aws_vpc.vpc_based_es.cidr_block,]
    }

    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_iam_service_linked_role" "es_access_role" {
    aws_service_name = "es.amazonaws.com"
    description = "AWSServiceRoleForAmazonElasticsearchService-demo"
}

resource "aws_iam_service_linked_role" "cognito_role" {
    aws_service_name = "cognito-identity.amazonaws.com"
}

resource "aws_cloudwatch_log_group" "cloudwatch_log" {
    name = "Logs"
}

resource "aws_cloudwatch_log_resource_policy" "es_metrics" {
    policy_name = "Elastic Search Logs"
    policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:logs:*"
    }
  ]
}
CONFIG

}
resource "aws_elasticsearch_domain" "es_demo" {
    domain_name = "elasticsearch-${data.aws_caller_identity.my_account.account_id}"
    elasticsearch_version = "7.7"

    cluster_config {
        instance_type = var.instance_type
        instance_count = var.instance_count
        dedicated_master_enabled = var.dedicated_master_enabled

    }

    ebs_options {
        ebs_enabled = var.ebs_enabled
        volume_size = "10"

    }

    vpc_options {
        subnet_ids = [var.subnet]
        security_group_ids = [aws_security_group.es_sg.id]

    }

    encrypt_at_rest {
        enabled = var.encrypt_at_rest
    }

    node_to_node_encryption {
        enabled = var.node_to_node_encryption
    }

    log_publishing_options {
        cloudwatch_log_group_arn = aws_cloudwatch_log_group.cloudwatch_log.arn
        log_type = var.log_type_search
    }

    log_publishing_options {
        cloudwatch_log_group_arn = aws_cloudwatch_log_group.cloudwatch_log.arn
        log_type = var.log_type_index
    }

    tags = {
        Domain = "ElasticSearch Instance"
    }
    depends_on = [aws_iam_service_linked_role.es_access_role]
}

resource "aws_elasticsearch_domain_policy" "es_demo_domain" {
    domain_name = aws_elasticsearch_domain.es_demo.domain_name
    access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Condition": {
                "IpAddress": {"aws:SourceIp": ${var.source_ip}
            },
            "Resource": "${aws_elasticsearch_domain.es_demo.arn}/*"
        }
    ]
}
POLICIES
}