resource "aws_vpc" "srvpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    tags = {
      "Name" = var.vpc_name
    }
}

resource "aws_internet_gateway" "igw"  {
  vpc_id = "${aws_vpc.srvpc.id}"
  tags = {
    "Name" = "${var.vpc_name}-igw"
  }
}