resource "azurerm_subnet" "subnetB" {
    name = "subnetB"
    resource_group_name = azurerm_resource_group.WSC.name
    virtual_network_name = azurerm_virtual_network.WSC.name
    address_prefix = "10.0.3.0/24"
}

resource "azurerm_subnet_network_security_group_association" "subnetB" {
  subnet_id                 = azurerm_subnet.subnetB.id
  network_security_group_id = azurerm_network_security_group.internal_only.id
}
