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
    rules = list(object({
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
    type      = string
    namespace = string
    data      = map(string)
  }))
  default = {}
}
