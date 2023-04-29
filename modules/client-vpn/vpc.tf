#Here we will create our networking resources
# Get AZs in our current region
data "aws_availability_zones" "available" {}

# create vpc in the region
resource "aws_vpc" "client_vpn_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "client-vpn-vpc"
  }
}

# Create public subnets
resource "aws_subnet" "public_subnet" {
  count                   = var.public-subnet
  cidr_block              = var.pub_cidrs[count.index]
  vpc_id                  = aws_vpc.client_vpn_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

}

# Create private subnets
resource "aws_subnet" "private_subnet" {
  count                   = var.private-subnet
  cidr_block              = var.pri_cidrs[count.index]
  vpc_id                  = aws_vpc.client_vpn_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]

}

# IGW for the public subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.client_vpn_vpc.id}"
}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.client_vpn_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

# Grant a egress-only internet access to our private subnet by creating NAT gateway with elastic IP.
# not that you will be billed for the nat gw and any unassigned EIP

resource "aws_eip" "eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}
# creates the nat-gateway in the public subnet
resource "aws_nat_gateway" "nat_gw" {
  subnet_id     = element(aws_subnet.public_subnet.*.id, 1)
  allocation_id = aws_eip.eip.id
  depends_on = [aws_internet_gateway.igw]
}

# Create a route table and associate the private rt to it.
resource "aws_route_table" "pri_sub_route_tbl" {
  vpc_id = aws_vpc.client_vpn_vpc.id
}

resource "aws_route" "priv_route" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
  route_table_id         = aws_route_table.pri_sub_route_tbl.id
}

resource "aws_route_table_association" "priv_sub_assoc" {
  count          = 3
  route_table_id = aws_route_table.pri_sub_route_tbl.id
  subnet_id      = aws_subnet.private_subnet.*.id[count.index]
  depends_on     = [aws_route_table.pri_sub_route_tbl, aws_subnet.private_subnet]
}