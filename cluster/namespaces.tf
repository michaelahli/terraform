resource "kubernetes_namespace" "stdns" {
  count = length(var.namespaces)

  metadata {
    name = var.namespaces[count.index]
  }
}
