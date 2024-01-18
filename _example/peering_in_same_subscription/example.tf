provider "azurerm" {
  features {}
}

module "resource_group_1" {
  source      = "cypik/resource-group/azure"
  version     = "1.0.1"
  name        = "app"
  environment = "test"
  location    = "West Europe"
}


module "resource_group_2" {
  source      = "cypik/resource-group/azure"
  version     = "1.0.1"
  name        = "app2"
  environment = "test"
  location    = "East US"
}



#Vnet
module "vnet" {
  source              = "cypik/vnet/azure"
  version             = "1.0.1"
  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group_1.resource_group_name
  location            = module.resource_group_1.resource_group_location
  address_space       = "10.0.0.0/16"
}

#Vnet
module "vnet_remote" {
  source              = "cypik/vnet/azure"
  version             = "1.0.1"
  name                = "app2"
  environment         = "test"
  resource_group_name = module.resource_group_2.resource_group_name
  location            = module.resource_group_2.resource_group_location
  address_space       = "20.0.0.0/16"
}

module "vnet_peering" {
  source                = "../.."
  enabled_peering       = true
  resource_group_1_name = module.resource_group_1.resource_group_name
  resource_group_2_name = module.resource_group_2.resource_group_name
  different_rg          = true
  vnet_1_name           = module.vnet.name
  vnet_1_id             = module.vnet.id
  vnet_2_name           = module.vnet_remote.name
  vnet_2_id             = module.vnet_remote.id
}
