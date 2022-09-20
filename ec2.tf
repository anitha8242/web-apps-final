# Create 1st EC2 instance in Public Subnet1
 resource "aws_instance" "instance" {
     ami           = "ami-05fa00d4c63e32376"
     instance_type = "t2.micro"
     key_name      = "master"
     vpc_security_group_ids = ["${aws_security_group.demosg.id}"]
     subnet_id              ="${aws_subnet.public-subnet-1.id}"
     associate_public_ip_address =true
     user_data = "${file("data.sh")}"
tags = {
 Name = "Instance1"
   }
}
# Create 2nd EC2 instance 
 resource "aws_instance" "demoinstance1" {
     ami           = "ami-05fa00d4c63e32376"
     instance_type = "t2.micro"
     key_name      = "master"
     vpc_security_group_ids =["${aws_security_group.demosg.id}"]
     subnet_id              ="${aws_subnet.public-subnet-2.id}"
     associate_public_ip_address =true
     user_data            ="${file("data1.sh")}"
tags = {
     Name = "Instance2"
}
}
