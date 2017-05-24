provider "aws" {
  region     = "us-east-1"
}

module "consul" {
  source = "github.com/nothere1/terraform/modules/consul/aws"

  region   = "${var.aws_region}"
  key_name = "${var.consul_key_name}"
  key_path = "${var.consul_key_path}"
  servers  = "${var.consul_cluster_size}"
  env      = "${var.env}"
}
