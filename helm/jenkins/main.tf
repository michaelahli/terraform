provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = "jenkins"
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "jenkins" {
  atomic = "true"
  name = "jenkins"
  namespace = "jenkins"
  version = "4.12.1"

  repository = "https://charts.jenkins.io"
  chart = "jenkins"

  values = [
    file ("values.yaml")
  ]
}
