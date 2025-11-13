provider "aws" {
  region = "eu-west-1"
}

locals {
  name        = "peering"
  environment = "test"
}

module "vpc-peering" {
  source = "./../../"

  name             = local.name
  environment      = local.environment
  requestor_vpc_id = "vpc-0cfff2d5f05914f3c"
  acceptor_vpc_id  = "vpc-0b9079d160060e1dc"
}