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








============

ec2-instance.tf
resource "aws_key_pair" "terraform-demo" {
  key_name   = "terraform-demo"
  public_key = "${file("terraform-demo.pub")}"
}

resource "aws_instance" "import_example" {
  ami           = "${lookup(var.ami,var.aws_region)}"
  instance_type = "${var.instance_type}"
  key_name      = "${aws_key_pair.terraform-demo.key_name}"
}

resource "aws_instance" "my-instance" {
  count         = "${var.instance_count}"
  ami           = "${lookup(var.ami,var.aws_region)}"
  instance_type = "${var.instance_type}"
  key_name      = "${aws_key_pair.terraform-demo.key_name}"
  user_data     = "${file("install_apache.sh")}"

  tags = {
    Name  = "${element(var.instance_tags, count.index)}"
    Batch = "5AM"
  }
}

output "ip" {
  value = "${aws_instance.my-instance.*.public_ip}"
}



=============
vars.tf
variable "ami" {
  type = "map"

  default = {
    "us-east-1" = "ami-04169656fea786776"
    "us-west-1" = "ami-006fce2a9625b177f"
  }
}

variable "instance_count" {
  default = "1"
}

variable "instance_tags" {
  type = "list"
  default = ["Terraform-1", "Terraform-2"]
}

variable "instance_type" {
  default = "t2.nano"
}

variable "aws_region" {
  default = "us-east-1"
}
