variable "create" {
  description = "Whether to create alb target group and alb rule"
  type        = bool
  default     = true
}

variable "create_alb_rule" {
  description = "Whether to create alb target group and alb rule"
  type        = bool
  default     = true
}


variable "name" {
  type        = string
  description = "Name of the target group. If omitted, Terraform will assign a random, unique name."
}

variable "protocol" {
  type        = string
  description = "Protocol to use to connect with the target. Defaults to HTTP"
  default     = "HTTP"
}

variable "port" {
  type = string
  description = "Port to use to connect with the target. Valid values are either ports 1-65535, or traffic-port. Defaults to traffic-port"
}

variable "vpc_id" {
  type        = string
  description = "Identifier of the VPC in which to create the target group. Required when target_type is instance, ip or alb. Does not apply when target_type is lambda"
}

variable "slow_start" {
  type        = string
  description = "(optional) describe your variable"
  default     = "60"
}

variable "target_type" {
  type        = string
  description = "(optional) describe your variable"
  default     = "ip"
}

variable "health_check" {
  description = "Map containing access logging configuration for load balancer."
  type        = map(string)
  default     = {}
}

variable "stickiness" {
  description = "Map containing access logging configuration for load balancer."
  type        = map(string)
  default     = {}
}

variable "target_group_rule" {
  type        = any
  default     = []
}

###
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "target_group_tags" {
  description = "A map of tags to add to load balancer target group"
  type        = map(string)
  default     = {}
}