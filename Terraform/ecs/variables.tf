variable "ecs_cluster_name" {
  type        = string
  description = "The ECS Cluster Name"
  default     = "nginx-cluster"
}

variable "desired_count" {
  type        = number
  description = "The number of desired instances for ECS service"
  default     = 1
}
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-1" 
}
variable "alb_name" {
  type        = string
  description = "The name of the ALB"
}
variable "tg_name" {
  type        = string
  description = "The name of the Target Group"
}