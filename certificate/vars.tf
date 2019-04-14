variable "aws_region" {
  description = "The region in which certificate should be created"
  default = "us-east-1"
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

variable "existing" {
  description = "Is the hosted zone avaialbe already?"
  default = false
}