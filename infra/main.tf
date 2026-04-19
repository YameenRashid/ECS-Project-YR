module "vpc" {
  source   = "./modules/vpc"
  az_1 = var.az_1
  az_2 = var.az_2
}

module "acm" {
  source   = "./modules/acm"
  domain_name = var.domain_name
  zone_name = var.zone_name
}

module "alb" {
  source   = "./modules/alb"
  public_subnet_1_id = module.vpc.public_1_subnet
  public_subnet_2_id = module.vpc.public_2_subnet
  vpc_id = module.vpc.vpc_id
  certificate_arn = module.acm.certificate_arn
  domain_name = var.domain_name
  zone_id = var.zone_id
}

module "ecr" {
  source    = "./modules/ecr"
  repo_name = "threatmod"
}

module "ecs" {
  source   = "./modules/ecs"
  app_image = "${module.ecr.repository_url}:latest"
  fargate_cpu = 256
  fargate_memory = 512
  target_group_arn = module.alb.tg_arn
  public_subnet_ids = [module.vpc.public_1_subnet, module.vpc.public_2_subnet]
  vpc_id = module.vpc.vpc_id
  alb_sg_id = module.alb.alb_sg_id
}

#OIDC
resource "aws_iam_openid_connect_provider" "default" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
}

#IAM OIDC Role
data "aws_iam_policy_document" "github_actions_assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.default.arn]
    
    }
    condition {
  test     = "StringLike"
  variable = "token.actions.githubusercontent.com:sub"
  values   = ["repo:YameenRashid/threatmod:*"]
}
  }
}

resource "aws_iam_role" "github_actions_role" {
  name               = "github-actions-role"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json
}

resource "aws_iam_role_policy_attachment" "admin" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}