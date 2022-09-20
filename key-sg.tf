# Creating Security Group
 resource "aws_security_group" "demosg" {
  vpc_id = "${aws_vpc.demovpc.id}"
# Inbound Rules
# HTTP access from anywhere 
ingress {
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
# HTTPS access from anywhere
ingress {
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  cidr_blocks =["0.0.0.0/0"]
}
# SSH access from anywhere
ingress {
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  cidr_blocks =["0.0.0.0/0"]
}
# Outbound Rules
# Internet access from anywhere
egress {
  from_port = 0
  to_port   = 0
  protocol  = "-1"
  cidr_blocks =["0.0.0.0/0"]
}
tags = {
 Name = "Web SG"
}
}

# Creating key_pair to attach EC2 Instance
resource "aws_key_pair" "key-pair" {
  key_name   = "master"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}
resource "local_file" "key-pair" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "master"
}
