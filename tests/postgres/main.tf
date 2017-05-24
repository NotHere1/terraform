provider "aws" {
  profile = "${var.aws_profile}"
  region = "${var.aws_region}"
}

data "aws_vpc" "selected" {
  tags = {
    env = "${var.env}"
    owner = "${var.aws_profile}"
  }
}

data "aws_subnet" "selected" {
  vpc_id = "${data.aws_vpc.selected.id}"
  tags {
      Name = "dev-private-subnet"
      owner = "${var.aws_profile}"
      env = "${var.env}"
  }
}

data "aws_security_group" "selected" {
  name = "${var.postgres_security_group_name}"
  vpc_id = "${data.aws_vpc.selected.id}"
}

module "postgres_iam_role" {
  source = "/Users/jng/Desktop/cota/projects/terraform/modules/iam/postgres"
  owner = "${var.developer}"
  env = "${var.env}"
}

resource "aws_instance" "postgres" {
  ami = "${var.postgres_ami}"
  key_name = "${var.key_name}"
  count = "${var.postgres_server_count}"
  security_groups = ["sg-0d2b6d73"]
  iam_instance_profile = "${module.postgres_iam_role.instance_profile_name}"
  subnet_id = "${data.aws_subnet.selected.id}"
  instance_type = "m4.large"

  ebs_block_device { 
    device_name = "/dev/xvdb"
    volume_size = "8"
    encrypted = "true"
  }

  ebs_block_device { 
    device_name = "/dev/xvdc"
    volume_size = "8"
    encrypted = "true"
  }

  connection {
    user = "ubuntu"
    private_key = "${file("${var.key_path}")}"
  }

  tags {
    Name = "${var.developer}-${var.env}-postgres-${count.index}"
    env = "${var.env}"
    role = "postgres"
    color = "blue"
  }
}
