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