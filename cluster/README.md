
# Kubernetes Cluster

Connected to kubernetes service to execute create ArgoCD instance.


## Installation

Install this project with `terraform init`

```bash
  terraform -chdir=cluster/ init -backend-config=variables/test/backend.conf
```
or if you want to reconfigure using different environments    
```bash
  terraform -chdir=cluster/ init -backend-config=variables/test/backend.conf -reconfigure
```
    
## Execute
Validate the code with `terraform validate`
```bash
  terraform -chdir=cluster/ validate 
```
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