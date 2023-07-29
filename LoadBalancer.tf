# Creating target group:
resource "aws_lb_target_group" "wordpress-lb-target-group" {
  name     = "Wordpress-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.wordpress-vpc.id
}

# Target group attachment (Add instances in it)
resource "aws_lb_target_group_attachment" "wordpress-lb-target-group-attachment-1" {
  target_group_arn = aws_lb_target_group.wordpress-lb-target-group.arn
  target_id        = aws_instance.pub-instance-1a.id
  port             = 80
}

# resource "aws_lb_target_group_attachment" "wordpress-lb-target-group-attachment-2" {
#   target_group_arn = aws_lb_target_group.wordpress-lb-target-group.arn
#   target_id        = aws_instance.pub-instance-1b.id
#   port             = 80
# }

# Creating lb listener
resource "aws_lb_listener" "wordpress-lb-listener" {
  load_balancer_arn = aws_lb.wordpress-application-lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-lb-target-group.arn
  }
}

# Load Balancer
resource "aws_lb" "wordpress-application-lb" {
  name               = "wordpress-application-lb"
  internal           = false
  load_balancer_type = "application"
  vpc_security_group_ids   = [aws_security_group.allow_22.id,aws_security_group.allow_80.id]
  subnets            = [aws_subnet.subnet-1-1a.id,aws_subnet.subnet-1-1b.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
    Owner = "Saloni"
  }
}

# Automatic Scaling Group - ASG
# Launch Template
resource "aws_launch_template" "wordpress-launch-template" {
  name_prefix   = "wordpress-launch-template"
  image_id      = "ami-0f69bc5520884278e"
  instance_type = "t2.micro"
  key_name = "demo-key"
  vpc_security_group_ids = [aws_security_group.allow_80.id,aws_security_group.allow_22.id]
  user_data = filebase64("user-data.sh")
   tags = {
    Environment = "production"
    Owner = "Saloni"
  }
}

# Automatic Scaling Group - ASG
resource "aws_autoscaling_group" "wordpress-ASG" {
  desired_capacity   = 2
  max_size           = 3
  min_size           = 2
  vpc_zone_identifier = [aws_subnet.subnet-1-1a.id,aws_subnet.subnet-1-1b.id]
  

  launch_template {
    id      = aws_launch_template.wordpress-launch-template.id
    version = "$Latest"
  }
}

# Load Balancer with ASG

resource "aws_lb_target_group" "wordpress-lb-target-grp-2" {
  name     = "wordpress-lb-target-grp-2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.wordpress-vpc.id
}

resource "aws_lb_listener" "wordpress-lb-listener-2" {
  load_balancer_arn = aws_lb.wordpress-lb-2.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-lb-target-grp-2.arn
  }
}

resource "aws_lb" "wordpress-lb-2" {
  name               = "wordpress-lb-2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_22.id,aws_security_group.allow_80.id]
  subnets            = [aws_subnet.subnet-1-1a.id,aws_subnet.subnet-1-1b.id]
}

resource "aws_autoscaling_attachment" "terramino" {
  autoscaling_group_name = aws_autoscaling_group.wordpress-ASG.id
  lb_target_group_arn   = aws_lb_target_group.wordpress-lb-target-grp-2.arn
}

# load balancer with ASH
# Target group
# listener
# Load Balancer
# Launch Template
# Auto Scaling Group
# Auto Scaling Group Attachment