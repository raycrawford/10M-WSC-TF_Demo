# Use
1. Install Terraform
1. Rename terraform.secrets.ps1.template to terraform.secrets.ps1
1. Configure terraform.secrets.ps1
1. Run `terraform plan`, giving values for admin_username and admin_password.  Alternatively, before running `terrform plan`, you can set the following variables in the PowerShell window you are running terrform from:
     * `$ENV:TF_VAR_admin_username=""`
     * `$ENV:TF_VAR_admin_password=""`
1. Run `terraform apply -auto-approve`, giving values for admin_username and admin_password

# Expectations
1. wsc-ad01 is available to WSC IP space
1. wsc-ls01 is available to WSC IP space
1. wsc-ad02 and wsc-ws01 (which are in the 10.0.3.0 subnet) are only available via 10.0.2.0 IP space in VNet
1. wsc-ad01 and wsc-ad02 can be configured as Domain Controllers in the same forest
1. wsc-ws01 can be joined to wsc-ad01 or wsc-ad02
