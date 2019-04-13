terraform {
  backend "local" {
    path = "state/website.tfstate"
  }
}

provider "aws" {
  region = "${var.aws_region}"
}

data "terraform_remote_state" "certificate" {
  backend = "local"
  config = {
    path = "state/certificate.tfstate"
  }
}


module storage {
  source = "git@github.com:juliuscanute/static-website-modules.git//storage?ref=0.0.1"
  aws_bucket_name = "${var.aws_bucket_name}"
  allowed_origins = ["*"]
}

module dns {
  source = "git@github.com:juliuscanute/static-website-modules.git//dns?ref=0.2.6"
  domain_name = "${var.domain_name}"
  alias_domain_name = "${module.cdn.cloudfront_domain_name}"
  alias_zone_id = "${module.cdn.cloudfront_hosted_zone_id}"
  existing = true
  create_record = true
}

module cdn {
  source = "git@github.com:juliuscanute/static-website-modules.git//cdn?ref=0.1.4"
  domain_name = "${module.storage.bucket_domain_name}"
  valid_aliases = "${var.alternative_names}"
  certificate_arn = "${data.terraform_remote_state.certificate.certificate_arn}"
}

module codebuild {
  source = "git@github.com:juliuscanute/static-website-modules.git//codebuild?ref=0.2.3"
  project_name = "my-personal-hugo-website"
  project_description = "Personal website created in Hugo"
  iam_role_arn = "${module.access_control.codebuild_iam_role_arn}"
  build_repository_name = "${var.build_repository_name}"
  aws_bucket_name = "${var.aws_bucket_name}"
}

module access_control {
  source = "git@github.com:juliuscanute/static-website-modules.git//access_control?ref=0.2.5"
  s3_bucket_arn = "${module.storage.bucket_arn}"
  s3_bucket_id = "${module.storage.bucket_id}"
  origin_iam_arn = "${module.cdn.origin_iam_arn}"
  codebuild_role_name = "hugo-builder-role"
}