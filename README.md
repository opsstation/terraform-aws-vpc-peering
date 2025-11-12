# terraform-aws-vpc-peering

# AWS Infrastructure Provisioning with Terraform-aws-vpc-Peering module

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Examples](#examples)
- [License](#license)


## Introduction

This module is designed for peering two Amazon Virtual Private Clouds (VPCs) using AWS infrastructure. It provides a streamlined way to create a VPC peering connection between two VPCs in the `eu-west-1` region. The module is customizable and can be easily integrated into your Terraform infrastructure.

## Usage

To use this module, you should have Terraform installed and configured for AWS. This module provides the necessary Terraform configuration for creating AWS resources, and you can customize the inputs as needed. Below is an example of how to use this module## examples

# Example: default
```hcl
# Requestor VPC provider
provider "aws" {
  region = "us-east-1"
}

module "vpc-peering" {
  source           = "git::https://github.com/opsstation/terraform-aws-vpc-peering.git?ref=v1.0.0"
  name             = "same-region-peering"
  environment      = "prod"
  requestor_vpc_id = "vpc-0d17e09526dd116c4"
  acceptor_vpc_id  = "vpc-0ace2232c2c10bc28"
  # auto_accept = true (default)
}
```

# Example: multi-region

```hcl
# Requestor VPC provider
provider "aws" {
  region = "us-west-1"
}

module "vpc-peering" {
  source           = "git::https://github.com/opsstation/terraform-aws-vpc-peering.git?ref=v1.0.0"
  name             = "multi-region-peering"
  environment      = "prod"
  label_order      = ["environment", "name"]
  requestor_vpc_id = "vpc-0408156477974f013"
  acceptor_vpc_id  = "vpc-07fca4b652df66412"
  accept_region    = "us-east-1"
  auto_accept      = false
}
```

```hcl
# Requestor account provider
provider "aws" {
  region = "us-west-1"
}

module "vpc-peering" {
  source           = "git::https://github.com/opsstation/terraform-aws-vpc-peering.git?ref=v1.0.0"
  name             = "cross-account-peering"
  environment      = "prod"
  requestor_vpc_id = "vpc-052ab4167f0a6279b"
  acceptor_vpc_id  = "vpc-03adbeb6bca829fb5"
  accept_region    = "us-east-1"
  auto_accept      = false
  peer_owner_id    = "xxxxxxxxxxx"  # Acceptor account ID
  acceptor_cidr_block = "10.0.0.0/24"  # Acceptor VPC CIDR
}
```


## Examples
For detailed examples on how to use this module, please refer to the [examples](https://github.com/opsstation/terraform-aws-vpc-peering/tree/master/_example) directory within this repository.

## License
This Terraform module is provided under the '[License Name]' License. Please see the [LICENSE](https://github.com/opsstation/terraform-aws-vpc-peering/blob/master/LICENSE) file for more details.

## Author
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.21.0 |
| <a name="provider_aws.peer"></a> [aws.peer](#provider\_aws.peer) | >= 5.21.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::https://github.com/opsstation/terraform-aws-labels.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route.acceptor_cross_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.acceptor_same_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.requestor_cross_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.requestor_same_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc_peering_connection.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection.region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_accepter.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [aws_region.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route_tables.acceptor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_route_tables.acceptor_multi_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_route_tables.requestor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_vpc.acceptor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc.acceptor_multi_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc.requestor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accept_region"></a> [accept\_region](#input\_accept\_region) | Acceptor region for cross-region peering | `string` | `""` | no |
| <a name="input_acceptor_allow_remote_vpc_dns_resolution"></a> [acceptor\_allow\_remote\_vpc\_dns\_resolution](#input\_acceptor\_allow\_remote\_vpc\_dns\_resolution) | Allow DNS resolution from acceptor VPC | `bool` | `false` | no |
| <a name="input_acceptor_cidr_block"></a> [acceptor\_cidr\_block](#input\_acceptor\_cidr\_block) | Acceptor VPC CIDR block (required for cross-account) | `string` | `""` | no |
| <a name="input_acceptor_vpc_id"></a> [acceptor\_vpc\_id](#input\_acceptor\_vpc\_id) | Acceptor VPC ID | `string` | n/a | yes |
| <a name="input_auto_accept"></a> [auto\_accept](#input\_auto\_accept) | Auto accept peering connection (true for same region, false for cross-region/cross-account) | `bool` | `true` | no |
| <a name="input_enable_peering"></a> [enable\_peering](#input\_enable\_peering) | Enable VPC peering | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., prod, dev, test) | `string` | `""` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`Environment`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | Managed by | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the peering connection | `string` | `""` | no |
| <a name="input_peer_owner_id"></a> [peer\_owner\_id](#input\_peer\_owner\_id) | AWS account ID of acceptor for cross-account peering | `string` | `""` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/opsstation/terraform-aws-vpc-peering"` | no |
| <a name="input_requestor_allow_remote_vpc_dns_resolution"></a> [requestor\_allow\_remote\_vpc\_dns\_resolution](#input\_requestor\_allow\_remote\_vpc\_dns\_resolution) | Allow DNS resolution from requestor VPC | `bool` | `false` | no |
| <a name="input_requestor_vpc_id"></a> [requestor\_vpc\_id](#input\_requestor\_vpc\_id) | Requestor VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accept_status"></a> [accept\_status](#output\_accept\_status) | The status of the VPC peering connection request. |
| <a name="output_connection_id"></a> [connection\_id](#output\_connection\_id) | VPC peering connection ID. |
| <a name="output_tags"></a> [tags](#output\_tags) | A mapping of tags to assign to the resource. |
<!-- END_TF_DOCS -->
