variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets"
}

variable "security_group_id" {
  type        = string
  description = "Security group for the infrastructure"
}

variable "execution_role_arn" {
  type        = string
  description = "The execution role ARN for ECS tasks"
}

variable "desired_count" {
  type        = number
  description = "The desired count of ECS tasks"
}
