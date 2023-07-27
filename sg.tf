resource "aws_security_group" "sg" {
    name = "allow all rules"
    description = "allow inbound and outbound rules"
    vpc_id = "${aws_vpc.srvpc.id}"
    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "value"
      from_port = 0
      protocol = "-1"
      to_port = 0
    }
    egress {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "value"
      from_port = 0
      protocol = "-1"
      to_port = 0
    }
tags = {
  "Name" = "${var.vpc_name}-sg"
}
    
}