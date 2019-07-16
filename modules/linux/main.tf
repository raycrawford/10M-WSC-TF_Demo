variable "prefix" {
  default = "wsc"
}

variable "machine_name" {
  default = "vm1"
}

variable "resource_group_name" {
  default = "walton-street-capital"
}

variable "location" {
  default = "eastus2"
}

variable "subnet_id" {}

variable "admin_username" {}
variable "admin_password" {}

variable "publisher" {}
variable "offer" {}
variable "sku" {}
variable "os_version" {}

resource "azurerm_public_ip" "module" {
  name                    = "${var.machine_name}-pubip"
  location                = var.location
  resource_group_name     = var.resource_group_name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "test"
  }
}

resource "azurerm_network_interface" "module" {
  name                = "${var.prefix}-${var.machine_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.module.id
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-${var.machine_name}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.module.id]
  vm_size               = "Standard_DS2_v2"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.os_version
  }
  storage_os_disk {
    name              = "${var.machine_name}-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.prefix}-${var.machine_name}"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
