
# Terraform ArgoCD

Connected to kubernetes service to execute create ArgoCD instance.


## Installation

Install this project with `terraform init`

```bash
  terraform -chdir=cluster/ init
```
    
## Execute

Review the plan with `terraform plan`

```bash
  terraform -chdir=cluster/ plan -var-file=variables/test/terraform.tfvars
```
Then apply the changes with `terraform apply`

```bash
  terraform -chdir=cluster/ apply -var-file=variables/test/terraform.tfvars -auto-approve
```
After done with testing, test object can be cleaned up with `terraform destroy`

```bash
  terraform -chdir=cluster/ destroy -var-file=variables/test/terraform.tfvars -auto-approve
```