provider "aws" {
  region = "eu-west-1"
}

module "vpc-peering" {
  source           = "./../.."
  name             = "vpc-peering"
  environment      = "prod"
  label_order      = ["environment", "name"]
  requestor_vpc_id = "vpc-0a4dc95ec370935bf"
  acceptor_vpc_id  = "vpc-04db274fdffd66e0d"
  accept_region    = "us-east-1"
  auto_accept      = false
}

