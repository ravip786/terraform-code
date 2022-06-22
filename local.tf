locals {
  payload_window_cidr_rules = [
    {
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allows IPv4 HTTP inbound taffic"
    },
    {
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow IPv4 all outbound traffic"
    },
    {
      type        = "egress"
      ipv6_cidr_blocks = ["::/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow IPv6 all outbound traffic"
    },
    {
      type        = "ingress"
      cidr_blocks = [module.vpc.vpc_cidr_block]
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      description = "Allow IPv4 all inbound traffic"
    }
  ]

  payload_window_alb_cidr_rules = [
    {
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allows IPv4 HTTP inbound taffic"
    },
    {
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow IPv4 all outbound traffic"
    },
    {
      type        = "egress"
      ipv6_cidr_blocks = ["::/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow IPv6 all outbound traffic"
    },
    {
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allows IPv4 HTTPS inbound taffic"
    },
    {
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Allows IPv4 HTTPS inbound taffic"
    }
      
  ]
}