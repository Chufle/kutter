resource "aws_lb" "kutter_lb" {
  name               = "kutter-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_http.id]
  subnets            = [aws_subnet.public_subnet_01.id, aws_subnet.public_subnet_02.id]

  enable_deletion_protection = false

 # access_logs {
 #   bucket  = aws_s3_bucket.nfish-des-kutter-lb-logs.bucket
 #   prefix  = "kutter-lb"
 #   enabled = true
 # }

 # tags = {
 #   Environment = "production"
 # }
}

resource "aws_security_group" "sg_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main_vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_lb_listener" "kutter_lb_listener" {
  load_balancer_arn = aws_lb.kutter_lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kutter_lb_tg.arn
  }
}

resource "aws_lb_target_group" "kutter_lb_tg" {
  name     = "lb-targetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id
}
