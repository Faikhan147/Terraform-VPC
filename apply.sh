#!/bin/bash

# Root directory
ROOT_DIR=$(pwd)
TFVARS_FILE="$ROOT_DIR/terraform.tfvars"  # single tfvars file

# Terraform init
echo "🔍 Initializing Terraform..."
terraform init -reconfigure

# Terraform validate & fmt
echo "✅ Validating configuration..."
terraform validate
echo "📝 Formatting Terraform files..."
terraform fmt -recursive

# Terraform plan
echo "📄 Creating plan..."
terraform plan -var-file="$TFVARS_FILE" -out=tfplan.out

# Show plan
echo "⚠️ Review the plan output:"
terraform show tfplan.out

# Prompt before apply
echo "🚀 Do you want to apply this plan? (yes/no)"
read choice

if [ "$choice" == "yes" ]; then
    echo "✅ Applying changes..."
    terraform apply -var-file="$TFVARS_FILE" -auto-approve

    echo "📊 Current state after apply:"
    terraform show
else
    echo "❌ Deployment cancelled."
fi
