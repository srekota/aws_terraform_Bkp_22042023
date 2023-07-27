resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.srvpc.id}"
    route {
        gateway_id = "${aws_internet_gateway.igw.id}"
        cidr_block = "0.0.0.0/0"
    }
    tags = {
        "Name" = "${var.vpc_name}-public-rt"
    }
}

resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.srvpc.id}"
    route {
        nat_gateway_id = "${aws_nat_gateway.ngw.id}"
        cidr_block = "0.0.0.0/0"
    }
    tags = {
        "Name" = "${var.vpc_name}-private-rt"
    }

}

resource "aws_route_table_association" "public1" {
    ##count = 2
    count = length(var.public_cidr_block)
    subnet_id = element(aws_subnet.public.*.id,count.index+1)
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private1" {
    ##count = 2
    count = length(var.private_cidr_block)
    subnet_id = element(aws_subnet.private.*.id,count.index+1)
    route_table_id = "${aws_route_table.private.id}"
}




