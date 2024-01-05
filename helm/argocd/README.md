
# Terraform ArgoCD

Connected to kubernetes service to execute create ArgoCD instance.


## Installation

Install this project with `terraform init`

```bash
  terraform -chdir=helm/argocd/ init
```
    
## Execute

Review the plan with `terraform plan`

```bash
  terraform -chdir=helm/argocd/ plan
```
Then apply the changes with `terraform apply`

```bash
  terraform -chdir=helm/argocd/ apply -auto-approve
```