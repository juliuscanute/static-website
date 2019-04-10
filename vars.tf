variable "aws_region" {
  description = "The region to which the bucket belongs"
  default = "us-east-1"
}

variable "domain_name" {
  description = "Name of the domain"
  default = "alghdscvb.com"
}

variable "alternative_names" {
  description = "Alternative names for this domain"
  default = ["alghdscvb.com","www.alghdscvb.com"]
  type = "list"
}

variable build_repository_name {
  type = "string"
  default = "hugo-builder"
}