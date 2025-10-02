variable "env" {
type = string
}





variable "vpc_cidr" {
type = string
}


variable "azs" {
description = "List of AZs to use (order matters)"
type = list(string)
}


variable "public_subnets" {
description = "List of CIDRs for public subnets (same length as azs)"
type = list(string)
}


variable "private_subnets" {
description = "List of CIDRs for private subnets (same length as azs)"
type = list(string)
}


variable "enable_flow_logs" {
type = bool
}


variable "tags" {
type = map(string)
}
