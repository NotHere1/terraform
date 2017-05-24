provider "aws" {
    profile = "${var.aws_profile}"
    region = "${var.aws_region}"
}

resource "aws_vpc" "this" {
    cidr_block = "${var.vpc_cidr}/16"
    tags {
        Name = "${var.env}-vpc"
        owner = "${var.aws_profile}"
        env = "${var.env}"
    }
}

# create a main public facing subnet
resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.this.id}"
    cidr_block = "${var.vpc_cidr}/24"
    map_public_ip_on_launch = "true"
    tags {
        Name = "public-${var.env}-subnet"
        owner = "${var.aws_profile}"
        env = "${var.env}"
    }
}

# create a private subnet
resource "aws_subnet" "private" {
    vpc_id = "${aws_vpc.this.id}"
    cidr_block = "${var.vpc_cidr}/24"
    map_public_ip_on_launch = "false"
    tags {
        Name = "private-${var.env}-subnet"
        owner = "${var.aws_profile}"
        env = "${var.env}"
    }
}
