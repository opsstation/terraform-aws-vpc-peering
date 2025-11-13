# Terraform AWS VPC Peering

[![Latest Release](https://img.shields.io/github/release/opsstation/terraform-aws-vpc-peering.svg)](https://github.com/opsstation/terraform-aws-vpc-peering/releases/latest)
[![tfsec](https://github.com/opsstation/terraform-aws-vpc-peering/actions/workflows/tfsec.yml/badge.svg)](https://github.com/opsstation/terraform-aws-vpc-peering/actions/workflows/tfsec.yml)
[![License](https://img.shields.io/badge/License-APACHE-blue.svg)](LICENSE.md)
[![Changelog](https://img.shields.io/badge/Changelog-blue)](CHANGELOG.md)

---

## 📘 Description

Terraform module to create and manage **AWS VPC Peering Connections** between two VPCs.
This module supports both **intra-account** and **cross-account** peering setups, including automatic route table updates and tagging via the [Labels Module](https://github.com/opsstation/terraform-aws-labels).

---

## ⚙️ Features

- ✅ Create **VPC Peering Connections** between same or different AWS accounts
- 🔄 Supports **auto-accept** for same-account setups
- 🧩 Integration with **Labels Module** for consistent tagging
- 🔐 Works with **cross-account** VPC peering
- 📈 Automatically updates **route tables** for communication between VPCs

---

## 🧱 Prerequisites

| Name | Version | URL |
|------|----------|-----|
| **Terraform** | >= 1.6.6 | [Install Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) |
| **AWS Provider** | >= 5.31.0 | [AWS Provider Docs](https://aws.amazon.com/) |

---

## 🧩 Module Dependencies

| Name | Description | URL |
|------|--------------|-----|
| **Labels Module** | Provides consistent tagging support for AWS VPC Peering connections. | [terraform-aws-labels](https://github.com/opsstation/terraform-aws-labels) |

---

## 🚀 Usage Example

Here’s how you can use this module in your Terraform configuration:

```hcl
### 🧩 Example 1: Default
module "vpc-peering" {
  source = "./../../"

  name             = local.name
  environment      = local.environment
  requestor_vpc_id = "vpc-0cfff2d5f05914f3c"
  acceptor_vpc_id  = "vpc-0b9079d160060e1dc"
}

### 🧩 Multi-Region VPC Peering

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
