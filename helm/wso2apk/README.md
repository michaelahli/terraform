
# WSO2APK API Management Server

Connected to kubernetes service to execute create metrics-server instance.

## Installation

Install this project with `terraform init`

```bash
  terraform -chdir=helm/wso2apk/ init
```
    
## Execute
Validate the code with `terraform validate`
```bash
  terraform -chdir=helm/wso2apk/ validate 
```
Review the plan with `terraform plan`

```bash
  terraform -chdir=helm/wso2apk/ plan
```
Then apply the changes with `terraform apply`

```bash
  terraform -chdir=helm/wso2apk/ apply -auto-approve
```
After done with testing, test object can be cleaned up with `terraform destroy`

```bash
  terraform -chdir=helm/wso2apk/ destroy -auto-approve
```