
#############################################################################
########################Window-Instance########################################
##############################################################################
module "aws_window" {
    source         =   "./modules/window_instance"
    name           =   "window_machine"
    instance_type  =   "t2.micro"
    ami            =   ""
    key_name       =   ""
    vpc_id         =   ""
    subnet_id      =   ""

    tags = {
    Terraform   = "true"
    Environment = "dev"
  }  
}
#################################################################################
################################Security_groups##################################
#################################################################################
module "window_alb_sg" {
  source                = "./modules/security_group"
  create                = true
  name                  = "Tcs-${var.environment}-Window-alb-security-group"
  vpc_id                = module.vpc.vpc_id
  source_cidr_block     = true
  source_cidr_rules     = local.payload_window_alb_cidr_rules
  source_security_group = false
  source_self           = false

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
##################################################################################################
##########################ALB##########################################################
##################################################################################################
module "window_lb" {
  source          = "./modules/aws_alb"
  create_lb       = true
  name            = "tcs-${var.environment}-window-alb"
  security_groups = [module.snipeit_alb_sg.security_group_id]
  subnets         = module.vpc.public_subnets

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
###############################################################################
########################ALBTG##############################################
###############################################################################
module "window_tg" {
  source          = "./modules/alb_tg"
  create          = true
  name            = "Tcs-${var.environment}-Window-alb-tg"
  protocol        = "HTTP"
  port            = "80"
  vpc_id          = module.vpc.vpc_id

  target_group_rule = [
    {
      listener_arn  = module.window_lb.lb_listener_arn
      priority      = "1"
      host_header   = "window.tcs.co"
    }
  ]

  health_check      = {
    matcher = "200-403"
  
  }
 
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}