resource "aws_vpc" "Lab_vpc" {
    cidr_block =var.vpc_cid

    tags = {
    Name = "var.vpc_name"
     }

}

resource "aws_subnet" "Private"{
     vpc_id =aws_vpc.Lab_vpc.id
     cidr_block = var.cidr_private

     tags = {
    Name = "Private"
     }

}

resource "aws_subnet" "Public"{
     vpc_id =aws_vpc.Lab_vpc.id
     cidr_block = var.cidr_public

     tags = {
    Name = "Public"
     }

}

resource "aws_subnet" "data"{
    vpc_id =aws_vpc.Lab_vpc.id

     cidr_block = var.cidr_data

     tags = {
    Name = "Data"
     }

}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Lab_vpc.id

  tags = {
    Name = "internet_gateway"
  }
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.Public.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]

}

resource "aws_eip" "nat_eip" {
    # instance = aws_instance.web.id
   vpc  = true 
}