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
