data aws_iam_policy_document "codedeploy_service_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
    sid = ""
  }
}

resource aws_iam_role "codedeploy_service" {
  name               = "codedeploy-service-${var.cluster_name}-${var.name}-${data.aws_region.current.name}"
  assume_role_policy = data.aws_iam_policy_document.codedeploy_service_assume.json
}

resource aws_iam_role_policy_attachment "codedeploy_service" {
  role       = aws_iam_role.codedeploy_service.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}