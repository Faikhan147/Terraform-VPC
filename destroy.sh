#!/bin/bash

# Root directory
ROOT_DIR=$(pwd)
TFVARS_FILE="$ROOT_DIR/terraform.tfvars"  # single tfvars file

# Prompt before destroy
echo "⚠️ Are you sure you want to destroy the VPC? (yes/no)"
read choice

if [ "$choice" != "yes" ]; then
    echo "❌ Destroy cancelled."
    exit 0
fi

# Terraform init
echo "🔍 Initializing Terraform..."
terraform init -reconfigure

# Destroy VPC
echo "💣 Destroying VPC..."
terraform destroy -var-file="$TFVARS_FILE" -auto-approve

# Show final state
echo "📊 Current Terraform state after destroy:"
terraform show
