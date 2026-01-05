resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name ="my-vpc"
    }
}
#creation od subnet-1
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "dev-public"
    }
}
#creation of subnet-2
resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
     tags = {
      Name = "dev"
    }
}
#creation of IG
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
  
}

#creation of RT
resource "aws_route_table" "name"{
    vpc_id = aws_vpc.name.id
    route {
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
        }
}  

#creation of SG
resource "aws_security_group" "dev_sg" {
  name   = "allow_tls"
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "dev-sg"
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #indicate all protocol 
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#creation of Instances
resource "aws_instance" "name" {
    ami = "ami-068c0051b15cdb816"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.dev_sg.id]
  
}


