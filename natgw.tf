resource "aws_eip" "eip" {
    tags = {
      "Name" = "${var.vpc_name}-igw"
    }
}

resource "aws_nat_gateway" "ngw" {
    subnet_id = "${aws_subnet.public.0.id}"
    allocation_id = "${aws_eip.eip.id}"
    tags = {
      "Name" = "${var.vpc_name}-ngw"
    }
    depends_on = [aws_internet_gateway.igw]
   
}
