# AWS EKS External Secrets Terraform module

Made by <img src="logo.png" width="60" margin alt="Miso"> with ❤️

## Description

A terraform module to deploy the External Secrets Operator on Amazon EKS cluster.

### Helm

Deploy helm chart by helm (default method, set `enabled = true`)

### Usage

You can use this module as follows:

```tf
locals {
  values = {
    "replicaCount" : 1
    "leaderElect" : true
    "podLabels" : {
      "app" : "external-secrets"
    }
  }
}
module "external_secrets_operator" {
  source = "git::https://github.com/getmiso/terraform-external-secrets-operator.git"
  enabled           = true
  helm_release_name = "external-secrets-operator"
  values = yamlencode(local.values)
}

```
