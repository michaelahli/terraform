provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.11.0"

  set {
    name  = "args[0]"
    value = "--kubelet-insecure-tls"
  }

  values = [
    file("values.yaml"),
  ]
}

output "metrics_server_release_name" {
  value = helm_release.metrics_server.name
}

output "metrics_server_release_namespace" {
  value = helm_release.metrics_server.namespace
}
