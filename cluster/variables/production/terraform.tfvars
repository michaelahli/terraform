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
cert_issuer_environments = {
    production = {
        namespace : "production-octopus"
        issuer_name : "letsencrypt-traefik-production"
        email : "cert@yopmail.com"
        acme_server : "https://acme-v02.api.letsencrypt.org/directory"
        secret_ref_name : "letsencrypt-traefik-production"
    },
    staging = {
        namespace : "staging-octopus"
        issuer_name : "letsencrypt-traefik-staging"
        email : "cert@yopmail.com"
        acme_server : "https://acme-v02.api.letsencrypt.org/directory"
        secret_ref_name : "letsencrypt-traefik-staging"
    }
}
kubernetes_secrets = {
    "staging-docker" = {
        type      = "kubernetes.io/dockerconfigjson"
        namespace = "staging-octopus"
        data      = { ".dockerconfigjson" = "eyJhdXRocyI6eyJob3N0LmRvY2tlci5pbnRlcm5hbDozMDUwMCI6eyJ1c2VybmFtZSI6ImJwY2xvdWRyZXBvc2l0b3J5IiwicGFzc3dvcmQiOiJLaWFzdTEyMyEiLCJhdXRoIjoiWW5CamJHOTFaSEpsY0c5emFYUnZjbms2UzJsaGMzVXhNak1oIn19fQ==" }
    },
    "production-docker" = {
        type      = "kubernetes.io/dockerconfigjson"
        namespace = "production-octopus"
        data      = { ".dockerconfigjson" = "eyJhdXRocyI6eyJob3N0LmRvY2tlci5pbnRlcm5hbDozMDUwMCI6eyJ1c2VybmFtZSI6ImJwY2xvdWRyZXBvc2l0b3J5IiwicGFzc3dvcmQiOiJLaWFzdTEyMyEiLCJhdXRoIjoiWW5CamJHOTFaSEpsY0c5emFYUnZjbms2UzJsaGMzVXhNak1oIn19fQ==" }
    },
    "octopus-secret-production" = {
        type      = "Opaque"
        namespace = "production-octopus"
        data      = { "DATABASE_PASSWORD" = "c3VwZXJzZWNyZXRwYXNzd29yZA==" }
    },
    "octopus-secret-staging" = {
        type      = "Opaque"
        namespace = "staging-octopus"
        data      = { "DATABASE_PASSWORD" = "c3VwZXJzZWNyZXRwYXNzd29yZA==" }
    }
}