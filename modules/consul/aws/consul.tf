resource "aws_security_group" "consul" {
    name = "${var.owner}_${var.env}_consul"
    description = "Consul internal traffic + maintenance."

    vpc_id = "${var.vpc_id}"

    // These are for internal traffic
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        self = true
    }

    ingress {
        from_port = 0
        to_port = 65535
        protocol = "udp"
        self = true
    }

    // These are for maintenance
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = "${var.security_group_ssh_ingress}"
    }

    // This is for outbound internet access
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "server" {

    # instance details
    ami = "${lookup(var.ami, "${var.region}-${var.platform}")}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    count = "${var.servers}"
    security_groups = ["${aws_security_group.consul.id}"]
    iam_instance_profile = "${var.ec2_readonly_iam_name}"
    subnet_id = "${var.subnet_id}"

    # connection details
    connection {
        user = "${lookup(var.user, var.platform)}"
        private_key = "${file("${var.key_path}")}"
    }

    #Instance tags
    tags {
        Name = "${var.tagName}-${var.env}-${count.index}"
        consul = "${var.env}"
        env = "${var.env}"
        role = "${var.tagName}"
        bootstrap = "${count.index == 0 ? true : false }"
    }
}
