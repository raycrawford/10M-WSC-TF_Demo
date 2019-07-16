resource "azurerm_network_security_group" "dmz" {
  name                = "dmz"
  location            = var.location
  resource_group_name = azurerm_resource_group.WSC.name
}

resource "azurerm_network_security_rule" "dmz_allow_out" {
  name                        = "dmz_allow_out"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.WSC.name
  network_security_group_name = azurerm_network_security_group.dmz.name
}

resource "azurerm_network_security_rule" "dmz_allow_internal_inbound" {
  name                        = "dmz_allow_internal"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.WSC.name
  network_security_group_name = azurerm_network_security_group.dmz.name
}

resource "azurerm_network_security_rule" "dmz_allow_external_inbound" {
  name                        = "dmz_allow_external"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = ["72.49.23.246", "12.154.222.62"]
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.WSC.name
  network_security_group_name = azurerm_network_security_group.dmz.name
}
