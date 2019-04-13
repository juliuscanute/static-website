variable "aws_region" {
  description = "The region to which the bucket belongs"
  default = "ap-southeast-2"
}

variable "domain_name" {
  description = "Name of the domain"
  default = "simplyteach.tk"
}

variable "alternative_names" {
  description = "Alternative names for this domain"
  default = ["simplyteach.tk","www.simplyteach.tk"]
  type = "list"
}

variable build_repository_name {
  type = "string"
  default = "juliuscanute/hugo-builder"
}

variable aws_bucket_name {
  type = "string"
  default = "hello-world-hugo-bucket"
}