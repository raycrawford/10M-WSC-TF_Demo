resource "azurerm_subnet" "subnetA" {
    name = "subnetA"
    resource_group_name = azurerm_resource_group.WSC.name
    virtual_network_name = azurerm_virtual_network.WSC.name
    address_prefix = "10.0.2.0/24"
}

resource "azurerm_subnet_network_security_group_association" "subnetA" {
  subnet_id                 = azurerm_subnet.subnetA.id
  network_security_group_id = azurerm_network_security_group.dmz.id
}
