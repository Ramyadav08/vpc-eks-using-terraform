output "vpc_id" {
    value = aws_vpc.my_vpc.id
    
}



output "app_tier_subnet_id" {
    value = aws_subnet.appsubnets[*].id
  
}

output "web_tier_subnet_id" {
    value = aws_subnet.websubnets[*].id
  
}