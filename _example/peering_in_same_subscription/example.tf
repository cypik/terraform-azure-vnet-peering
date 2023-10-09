provider "azurerm" {
  features {}
}

module "resource_group_1" {
  source      = "git::git@github.com:opz0/terraform-azure-resource-group.git?ref=master"
  name        = "appvm-linux"
  environment = "tested"
  location    = "West Europe"
}


module "resource_group_2" {
  source      = "git::git@github.com:opz0/terraform-azure-resource-group.git?ref=master"
  name        = "appvm-linux2"
  environment = "tested"
  location    = "East US"
}



#Vnet
module "vnet" {
  source              = "git::git@github.com:opz0/terraform-azure-vnet.git?ref=master"
  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group_1.resource_group_name
  location            = module.resource_group_1.resource_group_location
  address_space       = "10.0.0.0/16"
}

#Vnet
module "vnet_remote" {
  source              = "git::git@github.com:opz0/terraform-azure-vnet.git?ref=master"
  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group_2.resource_group_name
  location            = module.resource_group_2.resource_group_location
  address_space       = "20.0.0.0/16"
}

module "vnet_peering" {
  source = "../.."

  enabled_peering       = true
  resource_group_1_name = module.resource_group_1.resource_group_name
  resource_group_2_name = module.resource_group_2.resource_group_name

  different_rg = true
  vnet_1_name  = module.vnet.vnet_name[0]
  vnet_1_id    = module.vnet.vnet_id[0]
  vnet_2_name  = module.vnet_remote.vnet_name[0]
  vnet_2_id    = module.vnet_remote.vnet_id[0]

}
