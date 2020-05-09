#Tina Liu May 8th, 2020
#Usage:
# aws cloudformation termplate in terraform
#       VPC with:
#           1 Public Subnet
#           1 Private Subnet
#       An Internet Gateway 
#       And Route Table + Route + Route Table Associtaions for each subnet

# Configure the AWS Provider
provider "aws" {
    region  = "us-east-1" #maybe could do without hard coding this?
}

# Create a VPC
resource "aws_vpc" "PubPrivateVPC" {
    cidr_block = "172.31.0.0/16"
}

# Create Public Subnet
resource "aws_subnet" "PublicSubnet1"{
    vpc_id = aws_vpc.PubPrivateVPC.vpc_id #how do I reference the VPC. unsupprotted? error?
    cidr_block = "172.31.1.0/24"
    map_public_ip_on_launch = var.mapPublicIP 
}

# Create Private Subnet 
resource "aws_subnet" "PrivateSubnet1"{
    vpc_id = aws_vpc.PubPrivateVPC.vpc_id #how do I reference the VPC. unsupprotted? error?
    cidr_block = "172.31.3.0/24"
    map_private_ip_on_launch = var.mapPrivateIP #guess work, check this line 
}

# Create Internet Gateway
resource "aws_internet_gateway" "VPCGateway" {
 vpc_id = aws_vpc.PubPrivateVPC.id
}

# Create VPC Gateway Attachment 
#MISSING
# Create Public Route Table 
resource "aws_route_table" "PublicRouteTable" {
 vpc_id = aws_vpc.PubPrivateVPC.id

}
# Create Public Route 
#MISSING
# Create PublicSubnet1 Route Table Association
resource "aws_route_table_association" "PublicSubnet1RouteTableAssociation" {
  subnet_id      = aws_subnet.PubPrivateVPC.id
  route_table_id = aws_route_table.PublicRouteTable.id
}
# Create Private Route Table
resource "aws_route_table" "PrivateRouteTable" {
 vpc_id = aws_vpc.PubPrivateVPC.id

}
# Create Private Route
#MISSING
# Create PrivateSubnet1 Route Table Association 
resource "aws_route_table_association" "PrivateSubnet1RouteTableAssociation" {
  subnet_id      = aws_subnet.PubPrivateVPC.id
  route_table_id = aws_route_table.PrivateRouteTable.id
}

#extra thing??
# Create the Internet Access
#resource "aws_route" "My_VPC_internet_access" {
 # route_table_id         = aws_route_table.My_VPC_route_table.id
  #destination_cidr_block = var.destinationCIDRblock
  #gateway_id             = aws_internet_gateway.My_VPC_GW.id
#}

