resource "aws_instance" "public" {
    ##count = 1
    count = length(var.public_cidr_block)
    instance_type = "t2.micro"
    ami = "ami-069aabeee6f53e7bf"
    key_name = "sreedhar"
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = element(aws_subnet.public.*.id,count.index+1)
    associate_public_ip_address = true
    user_data = <<-EOF

    #!/bin/bash
    yum update -y
amazon-linux-extras install nginx1.12 -y
service nginx start
echo "<div><h1>PUBLIC-SERVER</h1></div>" >> /usr/share/nginx/html/index.html
echo "<div><h1>DEV-OPS 2023</h1></div>" >> /usr/share/nginx/html/index.html
EOF
  tags = {
    "Name" = "${var.vpc_name}-public${count.index+1}"
  }   

}

resource "aws_instance" "private" {
    ##count = 1
    count = length(var.private_cidr_block)
    instance_type = "t2.micro"
    ami = "ami-069aabeee6f53e7bf"
    key_name = "sreedhar"
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = element(aws_subnet.private.*.id,count.index+1)
    user_data = <<-EOF

    #!/bin/bash
    yum update -y
amazon-linux-extras install nginx1.12 -y
service nginx start
systemctl enable nginx
echo "<div><h1>PUBLIC-SERVER</h1></div>" >> /usr/share/nginx/html/index.html
echo "<div><h1>DEV-OPS 2023</h1></div>" >> /usr/share/nginx/html/index.html
EOF
  tags = {
    "Name" = "${var.vpc_name}-private${count.index+1}"

  }   

}
