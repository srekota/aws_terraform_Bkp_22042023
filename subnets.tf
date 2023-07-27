resource "aws_subnet" "public" {
    count = length(var.public_cidr_block)
  vpc_id = "${aws_vpc.srvpc.id}"
  cidr_block = element(var.public_cidr_block,count.index+1)
  availability_zone = element(var.azs,count.index+1)
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.vpc_name}-public${count.index+1}"

  }
  depends_on = [aws_subnet.private]
}

resource "aws_subnet" "private" {
    ##count = 2
    count = length(var.public_cidr_block)
  vpc_id = "${aws_vpc.srvpc.id}"
  cidr_block = element(var.private_cidr_block,count.index+1)
  availability_zone = element(var.azs,count.index+1)
  tags = {
    "Name" = "${var.vpc_name}-private${count.index+1}"

  }

}

