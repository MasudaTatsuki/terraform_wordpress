variable "security_groups" {
    type = set(string)
}

variable "subnets" {
    type = set(string)
}

variable "vpc_id" {
    type = string
}

variable "target_id" {
    type = string
}