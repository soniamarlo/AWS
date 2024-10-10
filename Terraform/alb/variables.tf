variable "alb_name" {
  type        = string
  description = "The name of the ALB"
}

variable "tg_name" {
  type        = string
  description = "The name of the target group"
}

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "eu-west-1"
}
