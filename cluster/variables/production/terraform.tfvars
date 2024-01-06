namespaces=["octopusdb","staging-octopus","production-octopus","gitness","registry","ingress","monitoring","argocd"]
role_environments = {
    "staging" = {
      namespace            = "staging-octopus"
      service_account_name = "octopus-service-account-staging"
      role_name            = "octopus-role-staging"
      role_binding_name    = "octopus-role-binding-staging"
      rules = [
            {
                api_groups = [""]
                resources  = ["pods"]
                verbs      = ["get", "list"]
            },
            {
                api_groups = ["apps"]
                resources  = ["deployments"]
                verbs      = ["get"]
            },
        ]
    },
    "production" = {
            namespace            = "production-octopus"
            service_account_name = "octopus-service-account-production"
            role_name            = "octopus-role-production"
            role_binding_name    = "octopus-role-binding-production"
            rules = [
            {
                api_groups = [""]
                resources  = ["pods"]
                verbs      = ["get", "list", "create"] 
            },
            {
                api_groups = ["apps"]
                resources  = ["deployments"]
                verbs      = ["get"]
            },
        ]
    }
}