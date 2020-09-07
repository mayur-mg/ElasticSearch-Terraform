output "elasticsearch_domain_id" {
  value = aws_elasticsearch_domain.es_demo.id
}

output "elasticsearch_domain_name" {
  value = aws_elasticsearch_domain.es_demo.domain_name
}

output "kibana_url" {
  value = aws_elasticsearch_domain.es_demo.kibana_endpoint
}