env = "prod"
region = "ap-southeast-2"
vpc_cidr = "10.0.0.0/16"
azs = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
public_subnets = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"]
private_subnets = ["10.0.10.0/24","10.0.11.0/24","10.0.12.0/24"]
enable_flow_logs = false
tags = {Name = "Faisal-VPC"}
