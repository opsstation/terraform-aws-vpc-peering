# terraform-aws-vpc-peering

[![OpsStation](https://img.shields.io/badge/Made%20by-OpsStation-blue?style=flat-square&logo=terraform)](https://www.opsstation.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.13%2B-purple.svg?logo=terraform)](#)
[![CI](https://github.com/OpsStation/terraform-multicloud-labels/actions/workflows/ci.yml/badge.svg)](https://github.com/OpsStation/terraform-multicloud-labels/actions/workflows/ci.yml)

> 🌩️ **A production-grade, reusable AWS Subnet module by [OpsStation](https://www.opsstation.com)**
> Designed for reliability, performance, and security — following AWS networking best practices.
---

## 🏢 About OpsStation

**OpsStation** delivers **Cloud & DevOps excellence** for modern teams:
- 🚀 **Infrastructure Automation** with Terraform, Ansible & Kubernetes
- 💰 **Cost Optimization** via scaling & right-sizing
- 🛡️ **Security & Compliance** baked into CI/CD pipelines
- ⚙️ **Fully Managed Operations** across AWS, Azure, and GCP

> 💡 Need enterprise-grade DevOps automation?
> 👉 Visit [**www.opsstation.com**](https://www.opsstation.com) or email **hello@opsstation.com**

---
🌟 Features

- Creates and manages AWS VPC Peering Connections between two VPCs
- Supports cross-region and cross-account VPC peering setups
- Automatically handles requestor and accepter side configuration
- Provides options for auto-accept or manual acceptance of peering requests
- Supports custom tagging using the Labels Module
- Automatically associates routes between peered VPCs for seamless connectivity
- Validates non-overlapping CIDR ranges to prevent peering conflicts
- Compatible with OpsStation Terraform Modules for VPC, Subnets, and Security Groups
- Enables fine-grained control for tagging, ownership, and acceptance policies
- Designed for both intra-account and inter-account VPC peering setups

# Example: default
```hcl
module "vpc-peering" {
  source           = "git::https://github.com/opsstation/terraform-aws-vpc-peering.git?ref=v1.0.0"
  name             = local.name
  environment      = local.environment
  requestor_vpc_id = "vpc-0d17e09526dd116c4"
  acceptor_vpc_id  = "vpc-0ace2232c2c10bc28"
}
```

# Example: multi-region

```hcl
module "vpc-peering" {
  source           = "git::https://github.com/opsstation/terraform-aws-vpc-peering.git?ref=v1.0.0"
  name             = "vpc-peering"
  environment      = "prod"
  label_order      = ["environment", "name"]
  requestor_vpc_id = "vpc-0408156477974f013"
  acceptor_vpc_id  = "vpc-07fca4b652df66412"
  accept_region    = "us-east-1"
  auto_accept      = false
}
```
## 📤 Outputs
| **Name**                     | **Description**                                                                                |
| ---------------------------- | ---------------------------------------------------------------------------------------------- |
| `vpc_peering_connection_id`  | The unique identifier (ID) of the created VPC Peering Connection.                              |
| `vpc_peering_connection_arn` | The Amazon Resource Name (ARN) of the created VPC Peering Connection.                          |
| `requestor_vpc_id`           | The ID of the VPC that initiated the peering connection (requestor side).                      |
| `acceptor_vpc_id`            | The ID of the peer VPC that receives the peering request (acceptor side).                      |
| `peer_owner_id`              | The AWS Account ID of the owner of the peer (acceptor) VPC.                                    |
| `peer_region`                | The AWS region of the peer (acceptor) VPC.                                                     |
| `status`                     | The current status of the VPC Peering Connection (e.g., active, pending-acceptance, failed).   |
| `auto_accept`                | Indicates whether the VPC Peering Connection was automatically accepted.                       |
| `route_table_associations`   | A list of route table IDs that have been updated for VPC peering connectivity (if applicable). |
| `tags`                       | A mapping of all tags assigned to the VPC Peering Connection.                                  |
| `name`                       | The name tag assigned to the VPC Peering Connection.                                           |
| `arn`                        | Alias output for `vpc_peering_connection_arn` (for compatibility with external references).    |

---
### ☁️ Tag Normalization Rules (AWS)

| Cloud | Case      | Allowed Characters | Example                            |
|--------|-----------|------------------|------------------------------------|
| **AWS** | TitleCase | Any              | `Name`, `Environment`, `CostCenter` |

---

### 💙 Maintained by [OpsStation](https://www.opsstation.com)
> OpsStation — Simplifying Cloud, Securing Scale.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.13.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.1.0 |
| <a name="provider_aws.peer"></a> [aws.peer](#provider\_aws.peer) | >= 5.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | opsstation/labels/multicloud | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route.acceptor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.acceptor-region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.requestor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.requestor-region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc_peering_connection.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection.region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_accepter.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route_tables.acceptor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_route_tables.requestor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_vpc.acceptor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc.requestor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accept_region"></a> [accept\_region](#input\_accept\_region) | The region of the accepter VPC of the VPC Peering Connection. | `string` | `""` | no |
| <a name="input_acceptor_allow_remote_vpc_dns_resolution"></a> [acceptor\_allow\_remote\_vpc\_dns\_resolution](#input\_acceptor\_allow\_remote\_vpc\_dns\_resolution) | Allow acceptor VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the requestor VPC. | `bool` | `true` | no |
| <a name="input_acceptor_vpc_id"></a> [acceptor\_vpc\_id](#input\_acceptor\_vpc\_id) | Acceptor VPC ID. | `string` | n/a | yes |
| <a name="input_auto_accept"></a> [auto\_accept](#input\_auto\_accept) | Automatically accept the peering (both VPCs need to be in the same AWS account). | `bool` | `true` | no |
| <a name="input_enable_peering"></a> [enable\_peering](#input\_enable\_peering) | Set to false to prevent the module from creating or accessing any resources. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`Environment`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy, eg 'opsstation'. | `string` | `"opsstation"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/opsstation/terraform-aws-vpc-peering"` | no |
| <a name="input_requestor_allow_remote_vpc_dns_resolution"></a> [requestor\_allow\_remote\_vpc\_dns\_resolution](#input\_requestor\_allow\_remote\_vpc\_dns\_resolution) | Allow requestor VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the acceptor VPC. | `bool` | `true` | no |
| <a name="input_requestor_vpc_id"></a> [requestor\_vpc\_id](#input\_requestor\_vpc\_id) | Requestor VPC ID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accept_status"></a> [accept\_status](#output\_accept\_status) | The status of the VPC peering connection request. |
| <a name="output_connection_id"></a> [connection\_id](#output\_connection\_id) | VPC peering connection ID. |
| <a name="output_tags"></a> [tags](#output\_tags) | A mapping of tags to assign to the resource. |
<!-- END_TF_DOCS -->