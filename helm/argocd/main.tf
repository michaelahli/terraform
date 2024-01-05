provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "argo_cd" {
  atomic     = "true"
  name       = "argo-cd"
  version    = "5.52.0"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  values = [
    file("values.yaml"),
  ]
}