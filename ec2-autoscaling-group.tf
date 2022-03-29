resource "aws_alb_target_group" "this" {
  name          = "myapp-alb-tg"
  target_type   = "alb"
  port          = 80
  protocol      = "TCP"
  vpc_id        = module.vpc.vpc_id

  tags = merge(var.extra_tags)
}

resource "aws_autoscaling_group" "this" {
  name               = "myapp-asg"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  desired_capacity   = 2
  max_size           = 4
  min_size           = 1
  target_group_arns  = [aws_alb_target_group.this.arn]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tags = merge(var.extra_tags)
}

# resource "aws_lb" "this" {
#   name               = "myapp-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.lb_sg.id]
#   subnets            = [for subnet in aws_subnet.public : subnet.id]

#   #enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.bucket
#     prefix  = "test-lb"
#     enabled = true
#   }

#   tags = merge(var.extra_tags)
# }

resource "aws_launch_template" "this" {
  name = "myapp-lt"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 30 #GB
    }
  }

  cpu_options {
    core_count       = 4
    threads_per_core = 2
  }

#   iam_instance_profile {
#     name = "test"
#   }

  image_id = "ami-0c02fb55956c7d316"

  instance_initiated_shutdown_behavior = "stop"

  instance_type = "t2.micro"

  key_name = "myapp-key"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination = true
  }

  vpc_security_group_ids = []

  tag_specifications {
    resource_type = "instance"

    tags = merge(var.extra_tags)
  }

  #user_data = filebase64("${path.module}/example.sh")
}