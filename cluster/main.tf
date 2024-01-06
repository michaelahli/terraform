provider "kubernetes" {
    config_path = "~/.kube/config"
}

variable "namespaces" {
  type        = list(string)
  description = "A list of namespaces to create."
  default     = [] 
}

variable "role_environments" {
  description = "Map of environments to create roles and role bindings for"
  type = map(object({
    namespace            = string
    service_account_name = string
    role_name            = string
    role_binding_name    = string
    rules                = list(object({
      api_groups = list(string)
      resources  = list(string)
      verbs      = list(string)
    }))
  }))
  default = {}
}

variable "cert_issuer_environments" {
  type = map(object({
    namespace : string
    issuer_name : string
    email : string
    acme_server : string
    secret_ref_name : string
  }))
  default = {}
}

variable "kubernetes_secrets" {
  description = "A map of Kubernetes secrets to create"
  type = map(object({
    type        = string
    namespace   = string
    data        = map(string)
  }))
  default = {}
}

resource "kubernetes_namespace" "stdns" {
  count = length(var.namespaces)

  metadata {
    name = var.namespaces[count.index]
  }
}

resource "kubernetes_role" "octopus_role" {
  for_each = var.role_environments

  metadata {
    name      = each.value.role_name
    namespace = each.value.namespace
  }

  dynamic "rule" {
    for_each = each.value.rules
    content {
      api_groups = rule.value.api_groups
      resources  = rule.value.resources
      verbs      = rule.value.verbs
    }
  }
}

resource "kubernetes_role_binding" "octopus_role_binding" {
  for_each = var.role_environments

  metadata {
    name      = each.value.role_binding_name
    namespace = each.value.namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = each.value.role_name
  }

  subject {
    kind      = "ServiceAccount"
    name      = each.value.service_account_name
    namespace = each.value.namespace
  }
}

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

resource "kubernetes_secret" "example" {
  for_each = var.kubernetes_secrets

  metadata {
    name      = each.key
    namespace = each.value.namespace
  }

  type = each.value.type

  data = each.value.data
}

output "namespace_ids" {
  value       = [for ns in kubernetes_namespace.stdns : ns.id]
  description = "The IDs of the created namespaces"
}

output "namespace_names" {
  value       = [for ns in kubernetes_namespace.stdns : ns.metadata.0.name]
  description = "The names of the created namespaces"
}

output "k8s_role_names" {
  value = { for key in keys(var.role_environments) : key => kubernetes_role.octopus_role[key].metadata[0].name }
  description = "A map of environment keys to Kubernetes role names."
}

output "k8s_role_binding_names" {
  value = { for key in keys(var.role_environments) : key => kubernetes_role_binding.octopus_role_binding[key].metadata[0].name }
  description = "A map of environment keys to Kubernetes role binding names."
}

output "created_secrets" {
  value = {
    for each in kubernetes_secret.example:
      "${each.metadata[0].namespace}/${each.metadata[0].name}" => each.id
  }
}