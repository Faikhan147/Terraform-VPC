env = "prod"
region = "us-east-1"
vpc_cidr = "10.0.0.0/16"
azs = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
public_subnets = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"]
private_subnets = ["10.0.10.0/24","10.0.11.0/24","10.0.12.0/24"]
enable_flow_logs = false
tags = {Name = "Faisal-VPC"}
