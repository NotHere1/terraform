variable "env" {
	type = "string"
}

variable "aws_profile" {
	type = "string"
}

variable "consul_key_path" {
	type = "string"
	description = "path to ec2 instance ssh key"
}

variable "consul_key_name" {
	type = "string"
	description = "ec2 instance ssh key name"
}

variable "consul_cluster_size" {
	type = "string"
	description = "cluster size of consul server"
	default = "3"
}

variable "aws_region" {
	type = "string"
	default = "us-east-1"
}

variable "vpc_cidr" {
	type = "string"
}

variable "owner" {
	type = "string"
}
