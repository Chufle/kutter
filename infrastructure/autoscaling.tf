resource "aws_launch_template" "kutter_webserver" {
  image_id      = "ami-!!!"
  instance_type = "t3.micro"
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 20
    }
  }
  iam_instance_profile {
    name = "!!!"
  }
  key_name = "!!!"
  vpc_security_group_ids = [aws_security_group.sg_http.id]
  user_data = filebase64("script/userdata.sh")
}

resource "aws_autoscaling_group" "kutter_autoscaling" {
  vpc_zone_identifier       = [aws_subnet.private_subnet_01.id, aws_subnet.private_subnet_02.id]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.kutter_webserver.id
    version = "$Latest"
  }
  depends_on = [
    aws_nat_gateway.nat_gw
  ]
  target_group_arns = [aws_lb_target_group.kutter_lb_tg.arn]
}
