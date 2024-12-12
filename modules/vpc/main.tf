#vpc
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      "Name"="My_Vpc"
    }
  
}


#subnet for web
resource "aws_subnet" "websubnets" {
  vpc_id     = aws_vpc.my_vpc.id
  count = length(var.web_subnet_cidr)
  cidr_block = var.web_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index] 
  map_public_ip_on_launch = true
  tags = {
    Name = var.web_subnet_name[count.index]
  }
}

#subnet for app
resource "aws_subnet" "appsubnets" {
  vpc_id     = aws_vpc.my_vpc.id
  count = length(var.app_subnet_cidr)
  cidr_block = var.app_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index] 
  
  tags = {
    Name = var.app_subnet_name[count.index]
  }
}



#internetgateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyInternetGateWay"
  }
}


#natgateway for app subnet01 and elasticip 
resource "aws_eip" "nat" {
  count = length(var.app_subnet_cidr)
  tags = {
    Name = "my-nat-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.app_subnet_cidr)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.websubnets[count.index].id

  tags = {
    Name = "my-nat-gateway-${count.index + 1}"
  }
}


#routetable for web
resource "aws_route_table" "web_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"   
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    Name = "my-web-rt"
  }

}

# Create Route Tables for app Subnets
resource "aws_route_table" "app_rt" {
  count  = length(var.app_subnet_cidr)
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "my-app-rt-${count.index + 1}"
  }
}



#routtable associate for web
resource "aws_route_table_association" "web_rt_asso" {
  count = length(var.web_subnet_cidr)
  subnet_id      = aws_subnet.websubnets[count.index].id
  route_table_id = aws_route_table.web_rt.id
}

# Associate each private route table with the corresponding private subnet
resource "aws_route_table_association" "app_rt_asso" {
  count          = length(var.app_subnet_cidr)
  subnet_id      = aws_subnet.appsubnets[count.index].id
  route_table_id = aws_route_table.app_rt[count.index].id
}

