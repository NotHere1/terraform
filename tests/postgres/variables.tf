variable "env" {
    type = "string"
}

variable "aws_profile" {
    type = "string"
}

variable "aws_region" {
    type = "string"
    default = "us-east-1"
}

variable "developer" {
    type = "string"
}

variable "postgres_ami" {
    type = "string"
    default = "ami-a6d4abb0"
}

variable "key_name" {
    type = "string"
    default = "development"
}

variable "key_path" {
    type = "string"
    default = "~/.ssh/cota/development.pem"
}

variable "postgres_server_count" {
    type = "string"
    default = "1"
}

variable "postgres_iam_profile" {
    type = "string"
    default = "postgres"
}

variable "postgres_security_group_name" {
    type = "string"
    default = "default"
}
