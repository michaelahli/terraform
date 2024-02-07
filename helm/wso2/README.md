
# WSO2 API Management Server

Connected to kubernetes service to execute create metrics-server instance.

## Prerequisite

Pull the helm image locally

```
git clone https://github.com/wso2/kubernetes-apim.git
```

Update helm dependencies, for example this is for am-single chart
```
pushd wso2/kubernetes-apim 
git checkout tags/v4.0.0.1
pushd simple/am-single
helm dependency update
popd && popd
```

Move to wso2 directory
```
mv kubernetes-apim wso2
```

Note: extensions/v1beta1 has been deprecated please update it to networking.k8s.io/v1

## Installation

Install this project with `terraform init`

```bash
  terraform -chdir=helm/wso2/ init
```
    
## Execute
Validate the code with `terraform validate`
```bash
  terraform -chdir=helm/wso2/ validate 
```
Review the plan with `terraform plan`

```bash
  terraform -chdir=helm/wso2/ plan
```
Then apply the changes with `terraform apply`

```bash
  terraform -chdir=helm/wso2/ apply -auto-approve
```
After done with testing, test object can be cleaned up with `terraform destroy`

```bash
  terraform -chdir=helm/wso2/ destroy -auto-approve
```