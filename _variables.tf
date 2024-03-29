variable "cluster_name" {
  type     = string
  nullable = false
}

variable "cluster_identity_oidc_issuer" {
  type        = string
  description = "The OIDC Identity issuer for the cluster"
  nullable = false
}

variable "helm_chart_name" {
  type        = string
  default     = "external-secrets"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "0.7.0"
  description = "Version of the Helm chart"
}

variable "helm_release_name" {
  type        = string
  default     = "external-secrets"
  description = "Helm release name"
}

variable "helm_repo_url" {
  type        = string
  default     = "https://charts.external-secrets.io"
  description = "Helm repository"
}

variable "helm_create_namespace" {
  type        = bool
  default     = true
  description = "Whether to create k8s namespace with name defined by `namespace`"
}

variable "namespace" {
  type        = string
  default     = "external-secrets"
  description = "The K8s namespace in which the external-secrets will be installed"
}

variable "values" {
  type        = string
  default     = ""
  description = "Additional yaml encoded values which will be passed to the Helm chart, see https://github.com/external-secrets/external-secrets/tree/main/deploy/charts/external-secrets#values"
}

