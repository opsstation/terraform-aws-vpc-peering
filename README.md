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
module "vpc_peering" {
  source      = "opsstation/vpc-peering/aws"
  version     = "1.0.0"
  name        = "app"
  environment = "test"

  requestor_vpc_id = "vpc-0123456789abcdef0"
  acceptor_vpc_id  = "vpc-0fedcba9876543210"

  # Optional - cross-account setup
  acceptor_account_id = "123456789012"

  auto_accept = true

  tags = {
    Project = "OpsStation"
  }
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
