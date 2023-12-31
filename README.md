# terraform-azure-vnet-peering
# Terraform Azure Infrastructure

This Terraform configuration defines an Azure infrastructure using the Azure provider.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Examples](#examples)
- [License](#license)

## Introduction
This repository contains Terraform code to deploy resources on Microsoft Azure, including a resource group and a virtual network peering.

## Usage
To use this module, you should have Terraform installed and configured for AZURE. This module provides the necessary Terraform configuration
for creating AZURE resources, and you can customize the inputs as needed. Below is an example of how to use this module:

# Examples

# Example: peering_in_diff_subscription

```hcl
module "vnet_peering" {
  source                        = "git::https://github.com/cypik/terraform-azure-vnet-peering.git?ref=v1.0.0"
  enabled_diff_subs_peering     = true
  resource_group_1_name         = module.resource_group.resource_group_name
  diff_subs_resource_group_name = data.azurerm_resource_group.resource_group_1.name
  alias_subs_id                 = "0a7be846-xxxxxxxxxxxxxx98787h"
  vnet_1_name                   = module.vnet.name
  vnet_1_id                     = module.vnet.id
  vnet_diff_subs_name           = data.azurerm_virtual_network.mgmt-staging-vnet.name
  vnet_diff_subs_id             = data.azurerm_virtual_network.mgmt-staging-vnet.id
}
```

# Example: peering_in_same_subscription

```hcl
module "vnet_peering" {
  source                = "git::https://github.com/cypik/terraform-azure-vnet-peering.git?ref=v1.0.0"
  enabled_peering       = true
  resource_group_1_name = module.resource_group_1.resource_group_name
  resource_group_2_name = module.resource_group_2.resource_group_name
  different_rg          = true
  vnet_1_name           = module.vnet.name
  vnet_1_id             = module.vnet.id
  vnet_2_name           = module.vnet_remote.name
  vnet_2_id             = module.vnet_remote.id
}
```
This example demonstrates how to create various AZURE resources using the provided modules. Adjust the input values to suit your specific requirements.

## Module Inputs
The following input variables can be configured:

- 'name': The name of the virtual network peering.
- 'resource_group_name': The name of the resource group in which to create the virtual network peering.
- 'virtual_network_name': The name of the virtual network.
- 'remote_virtual_network_id': The full Azure resource ID of the remote virtual network.

## Module Outputs
This module provides the following outputs:

- 'id': The ID of the Virtual Network Peering.

# Examples
For detailed examples on how to use this module, please refer to the '[examples](https://github.com/cypik/terraform-azure-vnet-peering/blob/master/_example)' directory within this repository.

# License
This Terraform module is provided under the '[License Name]' License. Please see the [LICENSE](https://github.com/cypik/terraform-azure-vnet-peering/blob/master/LICENSE) file for more details.

# Author
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.
