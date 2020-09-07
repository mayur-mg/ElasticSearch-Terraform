# ElasticSearch-Terraform
This Repository contains Terraform code to install elasticsearch

This assignment consists of 3 file - 
main.tf - Contain the main set of configuration of the ElasticSearch
variables.tf - Contain the variable definitions
output.tf - extracting the value of an output variable from the state file.


*************************************************************************************Instructions**************************************************************************
1. I have completed this assignment using Terraform instead of Ansible, because Terraform is more of an infrastructure provisioning tool. I do have good knowledge of Ansible also.

Note - While Running the Code or run the "terraform plan" and "terraform apply" command, prompt will ask you your IP and Subnet(Public or Private) in which you want to create the ElasticSearch Nodes.


2. Resources Used by me -

https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain
https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createdomain-configure-slow-logs.html

3. For me completing this assignment took approx. 3.5 hours.
Feedback - I haven't used AWS ElasticSearch before this assignment, so it helped me to understand ElasticSearch service. Also Problem Statement shared for the assignment was so clear, so Thanks for that.


1. What did you choose to automate the provisioning and bootstrapping of the instance? Why? 
Answer - I choose Terraform because it is an configuration orchestration tool that works with any cloud. It is immutable infrastructure.

2. How did you choose to secure ElasticSearch? Why?
Answer - SG are allowed for https protocal only, node to node encryption is enabled, Using Service-Linked Roles for Amazon ES so secure communication can happen.

3. How would you monitor this instance? What metrics would you monitor?
4. Could you extend your solution to launch a secure cluster of ElasticSearch nodes? What
would need to change to support this use case?
5. Could you extend your solution to replace a running ElasticSearch instance with little or no
downtime? How?
6. Was it a priority to make your code well structured, extensible, and reusable?
7. What sacrifices did you make due to time?
