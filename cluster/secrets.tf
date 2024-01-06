resource "kubernetes_secret" "example" {
  for_each = var.kubernetes_secrets

  metadata {
    name      = each.key
    namespace = each.value.namespace
  }

  type = each.value.type

  data = each.value.data
}
