provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "wso2" {
  atomic    = "true"
  name      = "wso2"
  namespace = "wso2"

  repository = "./kubernetes-apim/simple"
  chart      = "am-single"

  values = [
    file("values.yaml")
  ]

  create_namespace = true
  wait             = true
  reset_values     = true
}
