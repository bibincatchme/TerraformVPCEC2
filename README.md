# TerraformVPCEC2
Using terraform to create infrastrucutre on AWS using code. In this code, we are trying to create a below items:

VPC

Subnet inside VPC

Internet gateway associated with VPC

Route Table inside VPC with a route that directs internet-bound traffic to the internet gateway

Route table association with our subnet to make it a public subnet

Security group inside VPC

Key pair used for SSH access

EC2 instance inside our public subnet with an associated security group and generated a key pair

Using terraform we are able to make a immutable infrastructure which can be destroyed and created using single command.

Commands used:

terraform init : Initialize a Terraform working directory

terraform plan : Generate and show an execution plan

terraform apply : Builds or changes infrastructure

terraform destroy : Destroy Terraform-managed infrastructure

Variables are read from variables.tf file. If not specified in that file, parameters are read from following places :

Command line flags

File named terraform.tfvars, if name is something else can be provided using command line flag

Environment variables

UI input (only supports String variables)

