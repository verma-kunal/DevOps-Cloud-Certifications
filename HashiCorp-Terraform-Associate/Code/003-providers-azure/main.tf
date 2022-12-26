terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.33.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Creating a resource_group for azure:
resource "azurerm_resource_group" "tf_azure_provider" {
  name     = "tf_azure_provider"
  location = "East US"
}

# Setting up Azure VM using Azure's "compute" module (by Terraform):


module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.tf_azure_provider.name
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["my-tf-ubuntu"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]

  # Giving the size of vm - Basic:
  vm_size             = "Standard_B1ls"

  depends_on = [azurerm_resource_group.tf_azure_provider]
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.tf_azure_provider.name
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]

  depends_on = [azurerm_resource_group.tf_azure_provider]
}

# Outputs the public ip address of the server:
output "linux_vm_public_name" {
  value = module.linuxservers.public_ip_address
}