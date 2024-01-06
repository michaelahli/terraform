resource "kubernetes_manifest" "cert_issuer" {
  for_each = var.cert_issuer_environments

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Issuer"
    metadata = {
      name      = each.value.issuer_name
      namespace = each.value.namespace
    }
    spec = {
      acme = {
        server = each.value.acme_server
        email  = each.value.email
        privateKeySecretRef = {
          name = each.value.secret_ref_name
        }
        solvers = [{
          http01 = {
            ingress = {
              class = "traefik"
            }
          }
        }]
      }
    }
  }
}
