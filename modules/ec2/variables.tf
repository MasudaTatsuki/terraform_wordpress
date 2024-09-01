variable "subnet_id" {
    type = string
}

variable "security_group_ids" {
    type = set(string)
}

variable "db_name" {
    type = string
}

variable "db_password" {
    type = string
}

variable "db_user" {
    type = string
}

variable "db_address" {
    type = string
}