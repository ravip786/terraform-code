output "target_group_arn" {
  description = " ARN of the Target Group (matches id)."
  value       = concat(aws_lb_target_group.this.*.arn, [""])[0]
}

