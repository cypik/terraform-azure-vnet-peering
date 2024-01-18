provider "azurerm" {
  features {}
  subscription_id = "c468b1axxxxxxxxxxxxxxxxxxded9dw"
}

module "resource_group" {
  source      = "cypik/resource-group/azure"
  version     = "1.0.1"
  name        = "app"
  environment = "test"
  location    = "North Europe"
}


#Vnet
module "vnet" {
  source              = "cypik/vnet/azure"
  version             = "1.0.1"
  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = "172.0.0.0/16"
}


provider "azurerm" {
  alias = "mgmt"
  features {}
  subscription_id = "0a7be84xxxxxxxxxxxxxxxxxx5e"
}

data "azurerm_resource_group" "resource_group_1" {
  provider = azurerm.mgmt
  name     = "appvm-linux-tested-resource-group"
}

data "azurerm_virtual_network" "mgmt-staging-vnet" {
  provider            = azurerm.mgmt
  name                = "app-test-vnet"
  resource_group_name = data.azurerm_resource_group.resource_group_1.name
}

module "vnet_peering" {
  source                        = "../.."
  enabled_diff_subs_peering     = true
  resource_group_1_name         = module.resource_group.resource_group_name
  diff_subs_resource_group_name = data.azurerm_resource_group.resource_group_1.name
  alias_subs_id                 = "0a7be846-xxxxxxxxxxxxxx98787h"
  vnet_1_name                   = module.vnet.name
  vnet_1_id                     = module.vnet.id
  vnet_diff_subs_name           = data.azurerm_virtual_network.mgmt-staging-vnet.name
  vnet_diff_subs_id             = data.azurerm_virtual_network.mgmt-staging-vnet.id
}


