terraform {
  backend "local" {
    path = "state/certificate.tfstate"
  }
}

provider "aws" {
  region = "${var.aws_region}"
}

module certificate {
  source = "git@github.com:juliuscanute/static-website-modules.git//certificate?ref=0.1.6"
  domain_name = "${var.domain_name}"
  alternative_names = "${var.alternative_names}"
}

module dns {
  source = "git@github.com:juliuscanute/static-website-modules.git//dns?ref=0.2.6"
  domain_name = "${var.domain_name}"
  existing = false
}