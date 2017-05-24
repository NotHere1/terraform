provider "aws" {
    profile = "${var.aws_profile}"
    region = "${var.aws_region}"
}

resource "aws_vpc" "this" {
    cidr_block = "${var.vpc_cidr}/16"
    tags {
        Name = "${var.env}-vpc"
    }
}

resource "aws_subnet" "this" {
    vpc_id = "${aws_vpc.this.id}"
    cidr_block = "${var.vpc_cidr}/24"
    map_public_ip_on_launch = "false"
    tags {
        Name = "${var.owner}-${var.env}-subnet"
    }
}

# create ec2 read only iam role
module "ec2_readonly_iam_role" {
    source = "/Users/jng/Desktop/cota/projects/transcriptase/terraform/modules/iam/ec2_read_only"

    owner = "${var.owner}"
    env = "${var.env}"
}

# create consul cluster
module "consul" {
  source = "/Users/jng/Desktop/cota/projects/transcriptase/terraform/modules/consul/aws"

  region        = "${var.aws_region}"
  key_name      = "${var.consul_key_name}"
  key_path      = "${var.consul_key_path}"
  servers       = "${var.consul_cluster_size}"
  env           = "${var.env}"
  security_group_ssh_ingress = ["67.86.242.130/32"]
  instance_type      = "m3.medium"
  ec2_readonly_iam_name     = "${module.ec2_readonly_iam_role.instance_profile_name}"
  subnet_id = "${aws_subnet.this.id}"
  vpc_id = "${aws_vpc.this.id}"
  owner = "${var.owner}"
}
