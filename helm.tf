resource "helm_release" "external_secrets_operator" {
  chart            = var.helm_chart_name
  create_namespace = var.helm_create_namespace
  namespace        = var.namespace
  name             = var.helm_release_name
  version          = var.helm_chart_version
  repository       = var.helm_repo_url

  values = [
    var.values
  ]

  set {
    name  = "serviceAccount.create"
    value = true
  }
  set {
    name  = "serviceAccount.name"
    value = "external-secrets-operator"
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.this.arn
  }
}
