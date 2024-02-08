provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "wso2apk" {
  atomic    = "true"
  name      = "wso2apk"
  namespace = "wso2apk"

  repository = "https://github.com/wso2/apk/releases/download/1.0.0"
  chart      = "apk-helm"
  version    = "1.0.0"

  values = [
    file("values.yaml")
  ]

  create_namespace = true
  wait             = true
  reset_values     = true

  timeout = 600
}
