output "namespace_ids" {
  value       = [for ns in kubernetes_namespace.stdns : ns.id]
  description = "The IDs of the created namespaces"
}

output "namespace_names" {
  value       = [for ns in kubernetes_namespace.stdns : ns.metadata.0.name]
  description = "The names of the created namespaces"
}

output "k8s_role_names" {
  value       = { for key in keys(var.role_environments) : key => kubernetes_role.octopus_role[key].metadata[0].name }
  description = "A map of environment keys to Kubernetes role names."
}

output "k8s_role_binding_names" {
  value       = { for key in keys(var.role_environments) : key => kubernetes_role_binding.octopus_role_binding[key].metadata[0].name }
  description = "A map of environment keys to Kubernetes role binding names."
}

output "created_secrets" {
  value = {
    for each in kubernetes_secret.example:
      "${each.metadata[0].namespace}/${each.metadata[0].name}" => each.id
  }
}
