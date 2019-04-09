variable "aws_region" {
  description = "The region to which the bucket belongs"
  default = "ap-southeast-2"
}

variable "domain_name" {
  description = "Name of the domain"
  default = "myname.com"
}

variable "alternative_names" {
  description = "Alternative names for this domain"
  default = ["myname.com","www.myname.com"]
  type = "list"
}