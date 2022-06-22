resource "aws_lb_target_group" "this" {
  count       = var.create ? 1 : 0
  name        = var.name # name must be <= 32 chars
  protocol    = var.protocol
  port        = var.port
  vpc_id      = var.vpc_id
  slow_start  = var.slow_start
  target_type = var.target_type


  dynamic "health_check" {
    for_each = length(keys(var.health_check)) == 0 ? [] : [var.health_check]

    content {
      enabled             = lookup(health_check.value, "enabled", null)
      interval            = lookup(health_check.value, "interval", null)
      path                = lookup(health_check.value, "path", null)
      port                = lookup(health_check.value, "port", null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      timeout             = lookup(health_check.value, "timeout", null)
      protocol            = lookup(health_check.value, "protocol", null)
      matcher             = lookup(health_check.value, "matcher", null)
    }
  }

  dynamic "stickiness" {
    for_each = length(keys(var.stickiness)) == 0 ? [] : [var.stickiness]

    content {
      enabled         = lookup(stickiness.value, "enabled", null)
      cookie_duration = lookup(stickiness.value, "cookie_duration", null)
      type            = lookup(stickiness.value, "type", null)
      cookie_name     = lookup(stickiness.value, "cookie_name", null)
    }
  }

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
    var.target_group_tags,
  )
}

resource "aws_lb_listener_rule" "this" {
  count        = var.create_alb_rule ? length(var.target_group_rule) : 0
  listener_arn = lookup(var.target_group_rule[count.index], "listener_arn", null)
  priority     = lookup(var.target_group_rule[count.index], "priority", null)

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[0].arn
  }

  condition {
    host_header {
      values = [lookup(var.target_group_rule[count.index], "host_header", null)]
    }
  }
}



