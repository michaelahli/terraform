
# ArgoCD

Connected to kubernetes service to execute create ArgoCD instance.


## Installation

Install this project with `terraform init`

```bash
  terraform -chdir=helm/argocd/ init -backend-config=backend.conf
```
or if you want to reconfigure using different environments    
```bash
  terraform -chdir=helm/argocd/ init -backend-config=backend.conf -reconfigure
```
    
## Execute
Validate the code with `terraform validate`
```bash
  terraform -chdir=helm/argocd/ validate 
```
Review the plan with `terraform plan`

```bash
  terraform -chdir=helm/argocd/ plan
```
Then apply the changes with `terraform apply`

```bash
  terraform -chdir=helm/argocd/ apply -auto-approve
```
After done with testing, test object can be cleaned up with `terraform destroy`

```bash
  terraform -chdir=helm/argocd/ destroy -auto-approve
```