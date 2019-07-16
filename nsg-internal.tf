resource "azurerm_network_security_group" "internal_only" {
  name                = "internal_only"
  location            = var.location
  resource_group_name = azurerm_resource_group.WSC.name
}

resource "azurerm_network_security_rule" "allow_out" {
  name                        = "allow_out"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.WSC.name
  network_security_group_name = azurerm_network_security_group.internal_only.name
}

resource "azurerm_network_security_rule" "allow_internal_inbound" {
  name                        = "allow_internal"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.WSC.name
  network_security_group_name = azurerm_network_security_group.internal_only.name
}
