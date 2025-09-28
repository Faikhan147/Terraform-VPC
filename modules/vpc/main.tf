locals {
vpc_endpoint_type = "Gateway"
route_table_ids = concat([aws_route_table.public.id], values(aws_route_table.private).* .id)
tags = { Name = "${var.env}-dynamodb-endpoint" }
}


# Flow logs (optional) -> to CloudWatch Logs (create log group)
resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
count = var.enable_flow_logs ? 1 : 0
name = "/aws/vpc/flow-logs/${var.env}-${aws_vpc.this.id}"
retention_in_days = 90
}


resource "aws_flow_log" "vpc" {
count = var.enable_flow_logs ? 1 : 0
log_destination_type = "cloud-watch-logs"
log_group_name = aws_cloudwatch_log_group.vpc_flow_logs[0].name
iam_role_arn = aws_iam_role.vpc_flow_logs.arn
resource_id = aws_vpc.this.id
traffic_type = "ALL"
}


resource "aws_iam_role" "vpc_flow_logs" {
count = var.enable_flow_logs ? 1 : 0
name = "${var.env}-vpc-flow-logs-role"
assume_role_policy = data.aws_iam_policy_document.vpc_flow_logs_assume.json
}


data "aws_iam_policy_document" "vpc_flow_logs_assume" {
statement {
actions = ["sts:AssumeRole"]
principals {
type = "Service"
identifiers = ["vpc-flow-logs.amazonaws.com"]
}
}
}


resource "aws_iam_role_policy_attachment" "flow_logs_attach" {
count = var.enable_flow_logs ? 1 : 0
role = aws_iam_role.vpc_flow_logs[0].name
policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs" # replace if needed
}


# Basic default security group
resource "aws_security_group" "default_sg" {
name = "${var.env}-default-sg"
description = "Default SG for ${var.env}"
vpc_id = aws_vpc.this.id
tags = { Name = "${var.env}-default-sg" }


ingress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = [aws_vpc.this.cidr_block]
description = "Allow intra-vpc"
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
