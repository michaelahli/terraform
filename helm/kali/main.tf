provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "hackspace" {
  metadata {
    name = "hackspace"
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "kalivm" {
  atomic = "true"
  name = "kalivm"
  namespace = "hackspace"
  
  repository = "https://simonmisencik.github.io/helm-charts"
  chart = "kali"

  values = [
    file ("values.yaml"),
  ]
}
