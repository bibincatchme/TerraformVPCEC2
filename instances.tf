resource "aws_instance" "webserver" {
	count = "${length(var.subnets_cidr)}"
	ami = "${var.webservers_ami}"
	instance_type = "${var.instance_type}"
	security_groups = ["${aws_security_group.webservers.id}"]
	subnet_id = "${element(aws_subnet.public.*.id,count.index)}"
	user_data = "${file("install_httpd.sh")}"
        key_name = "${aws_key_pair.ec2key.key_name}"
	tags = {
	  Name = "Server-${count.index}"
	}
}
