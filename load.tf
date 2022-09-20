resource "aws_lb_target_group" "tf-elb" {
  name     = "tf-elb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.demovpc.id
}
# Creating External LoadBalancer
resource "aws_lb" "tf-elb" {
  name               = "Load-Balancer-new"
  internal           = "false"
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.demosg.id}"]
  subnets            = ["${aws_subnet.public-subnet-1.id}", "${aws_subnet.public-subnet-2.id}"]
}
# Attach the target group to load balaner
resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = aws_lb_target_group.tf-elb.arn
  target_id        = aws_instance.instance.id
  port             = "80"
  depends_on = [
    aws_instance.instance
  ]
}
resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.tf-elb.arn
  target_id        = aws_instance.demoinstance1.id
  port             = 80
  depends_on = [
    aws_instance.demoinstance1
  ]
}
resource "aws_lb_listener" "tf-elb" {
  load_balancer_arn = aws_lb.tf-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf-elb.arn
  }
}
