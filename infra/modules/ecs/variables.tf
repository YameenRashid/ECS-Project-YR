variable "app_image" {
    type = string
}

variable "fargate_cpu" {
    type = number
}

variable "fargate_memory" {
    type = number
}

variable "target_group_arn" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "vpc_id" {
    type = string
}

variable "alb_sg_id" {
    type = string
}