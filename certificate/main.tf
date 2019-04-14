terraform {
  backend "local" {
    path = "state/certificate/certificate.tfstate"
  }
}

provider "aws" {
  region = "${var.aws_region}"
}

module certificate {
  source = "git@github.com:juliuscanute/static-website-modules.git//certificate?ref=0.2.7"
  domain_name = "${var.domain_name}"
  alternative_names = "${var.alternative_names}"
  zone_id = "${element(module.dns.zone_id,0)}"
}

module dns {
  source = "git@github.com:juliuscanute/static-website-modules.git//dns?ref=0.2.6"
  domain_name = "${var.domain_name}"
  existing = false
  create_record = false
}