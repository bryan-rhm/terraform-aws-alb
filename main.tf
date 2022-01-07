resource "aws_lb" "alb" {
  name                             = var.name
  subnets                          = var.subnet_ids
  internal                         = var.internal_alb #tfsec:ignore:aws-elbv2-alb-not-public
  idle_timeout                     = local.idle_timeout
  security_groups                  = local.security_groups
  load_balancer_type               = var.loadbalancer_type
  drop_invalid_header_fields       = local.drop_invalid_header_fields
  enable_deletion_protection       = var.enable_deletion_protection
  enable_cross_zone_load_balancing = local.enable_cross_zone_load_balancing

  dynamic "access_logs" {
    for_each = var.access_logs_bucket_name != null ? [1] : []
    content {
      enabled = true
      bucket  = var.access_logs_bucket_name
      prefix  = var.access_logs_prefix
    }
  }

  tags = var.tags
}

resource "aws_lb_listener" "http_listener" {
  count             = var.loadbalancer_type == "application" ? 1 : 0
  
  port              = "80"
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.alb.arn

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  count             = var.ssl_certificate_arn != null && var.loadbalancer_type == "application" ? 1 : 0
  
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.ssl_certificate_arn
  load_balancer_arn = aws_lb.alb.arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Page not found"
      status_code  = "404"
    }
  }
}
