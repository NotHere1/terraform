variable "vpc_tenancy" {
    default = "default"
    description = "dedicated | default"
}

variable "vpc_cidr_block" {
    default = "10.32.0.0/16"
}

variable "name" {
    type = "string"
}
