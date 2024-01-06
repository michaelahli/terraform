namespaces=["testns"]
role_environments = {
    "test" = {
      namespace            = "testns"
      service_account_name = "octopus-service-account-test"
      role_name            = "octopus-role-test"
      role_binding_name    = "octopus-role-binding-test"
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
    }
}
cert_issuer_environments = {
    test = {
        namespace : "testns"
        issuer_name : "letsencrypt-traefik-test"
        email : "testcert@yopmail.com"
        acme_server : "https://acme-v02.api.letsencrypt.org/directory"
        secret_ref_name : "letsencrypt-traefik-test"
    }
}