data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "eks_oidc_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${replace(var.cluster_identity_oidc_issuer, "https://", "")}:sub"
      values = [
        "system:serviceaccount:${var.namespace}:external-secrets-operator"
      ]
    }
    principals {
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(var.cluster_identity_oidc_issuer, "https://", "")}"
      ]
      type = "Federated"
    }
  }
}

resource "aws_iam_role" "this" {
  name                  = "${var.cluster_name}-external-secrets-operator-role"
  description           = "Role that holds permissions for external-secrets-operator"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.eks_oidc_assume_role.json
}

resource "aws_iam_policy" "this" {
  name        = "${var.cluster_name}-external-secrets-policy"
  description = "Permissions that are required to manage secrets."
  policy      = <<-POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["secretsmanager:GetSecretValue", "ssm:GetParameter"],
            "Resource": "*"
        }
    ]
}
  POLICY
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}
