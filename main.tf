    
data "azurerm_client_config" "current" {}
data "azurerm_subscription" "primary" {}


resource "azurerm_resource_group" "WSC" {
  name     = "walton-street-capital"
  location = var.location
}

resource "azurerm_virtual_network" "WSC" {
  name                = "wsc-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.WSC.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    environment = "Sandbox"
  }
}

module "windowsVM_AD01" {
  source = "./modules/windows"
  resource_group_name = azurerm_resource_group.WSC.name
  location = var.location
  machine_name = "ad01"
  subnet_id = azurerm_subnet.subnetA.id
  admin_username = var.admin_username
  admin_password = var.admin_password
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2016-Datacenter"
  os_version   = "latest"
}

module "centosVM_LS01" {
  source = "./modules/linux"
  resource_group_name = azurerm_resource_group.WSC.name
  location = var.location
  machine_name = "ls01"
  subnet_id = azurerm_subnet.subnetA.id
  admin_username = var.admin_username
  admin_password = var.admin_password
  publisher = "OpenLogic"
  offer     = "CentOS"
  sku       = "7.5"
  os_version   = "latest"
}

module "windowsVM_AD02" {
  source = "./modules/windows"
  resource_group_name = azurerm_resource_group.WSC.name
  location = var.location
  machine_name = "ad02"
  subnet_id = azurerm_subnet.subnetB.id
  admin_username = var.admin_username
  admin_password = var.admin_password
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2016-Datacenter"
  os_version   = "latest"
}

module "windowsVM_WS01" {
  source = "./modules/windows"
  resource_group_name = azurerm_resource_group.WSC.name
  location = var.location
  machine_name = "ws01"
  subnet_id = azurerm_subnet.subnetB.id
  admin_username = var.admin_username
  admin_password = var.admin_password
  publisher = "MicrosoftWindowsDesktop"
  offer     = "Windows-10"
  sku       = "rs5-pron"
  os_version   = "latest"
}
