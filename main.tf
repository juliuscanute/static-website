provider "aws" {
  region = "${var.aws_region}"
}

module storage {
  source = "git@github.com:juliuscanute/static-website-modules.git//storage?ref=0.0.1"
  aws_bucket_name = "hello-world-hugo-bucket"
  allowed_origins = ["*"]
}

module certificate {
  source = "git@github.com:juliuscanute/static-website-modules.git//certificate?ref=0.0.5"
  domain_name = "${var.domain_name}"
  alternative_names = "${var.alternative_names}"
  zone_id = "${module.dns.zone_id}"
}

module dns {
  source = "git@github.com:juliuscanute/static-website-modules.git//dns?ref=0.0.5"
  domain_name = "${var.domain_name}"
  alias_domain_name = "${module.cdn.cloudfront_domain_name}"
  alias_zone_id = "${module.cdn.cloudfront_hosted_zone_id}"
}

module cdn {
  source = "git@github.com:juliuscanute/static-website-modules.git//cdn?ref=0.0.1"
  domain_name = "${var.domain_name}"
  valid_aliases = "${var.alternative_names}"
  certificate_arn = "${module.certificate.certificate_arn}"
}

module codebuild {
  source = "git@github.com:juliuscanute/static-website-modules.git//codebuild?ref=0.0.6"
  project_name = "my-personal-hugo-website"
  project_description = "Personal website created in Hugo"
  iam_role_arn = "aws-hugo-code-build"
  build_repository_name = "hugo-builder"
}

module access_control {
  source = "git@github.com:juliuscanute/static-website-modules.git//access_control?ref=0.0.3"
  s3_bucket_arn = "${module.storage.bucket_arn}"
  s3_bucket_id = "${module.storage.bucket_id}"
  origin_iam_arn = "${module.cdn.origin_iam_arn}"
  codebuild_role_name = "hugo-builder-role"
  repository_policy_name = "hugo-image-access-policy"
}