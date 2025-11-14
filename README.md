# 🏗️ Terraform-AWS-VPC-Peering

[![OpsStation](https://img.shields.io/badge/Made%20by-OpsStation-blue?style=flat-square&logo=terraform)](https://www.opsstation.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.6%2B-purple.svg?logo=terraform)](#)
[![CI](https://github.com/OpsStation/terraform-aws-vpc/actions/workflows/ci.yml/badge.svg)](https://github.com/OpsStation/terraform-aws-vpc-peering/actions/workflows/ci.yml)

> A production-grade, reusable AWS VPC Peering module by OpsStation Designed for secure, scalable, and automated network connectivity across AWS accounts and regions.**
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

## 🌟 Features

🌟 Features
- 🔗 Creates AWS VPC Peering Connections
- 🌍 Supports same-region and cross-region configurations
- 👥 Full cross-account support (acceptance must be done manually)
- ⚡ Auto-accept enabled for same-account peerings
- 📡 Automatically configures route tables for both VPCs
- 🧱 Validates CIDR blocks to avoid overlapping networks
- 🏷️ Clean and consistent tagging using OpsStation label standards

---

### 🟢 Example: Same-Region Peering

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

# Example: multi-region-peering
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

# Example: cross-account-peering
#Important: For cross-account VPC peering, auto_accept must remain false, as AWS does not allow automatic acceptance across different accounts. The connection must be manually approved from the accepter account
```hcl
# Requestor account provider
provider "aws" {
  region = "us-west-1"
}

module "vpc-peering" {
  source               = "git::https://github.com/opsstation/terraform-aws-vpc-peering.git?ref=v1.0.0"
  name                 = "cross-account-peering"
  environment          = "prod"
  requestor_vpc_id     = "vpc-052ab4167f0a6279b"
  acceptor_vpc_id      = "vpc-03adbeb6bca829fb5"
  accept_region        = "us-east-1"
  auto_accept          = false
  peer_owner_id        = "xxxxxxxxxxx"
  acceptor_cidr_block  = "10.0.0.0/24"
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