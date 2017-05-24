variable "vpc_id" {
    type = "string"
}

variable "subnet_cidr_block" {
    type = "string"
}

variable "enable_public_ip" {
    default = "false"
}

variable "name" {
    type = "string"
}
