resource "azurerm_dns_zone" "main" {
  resource_group_name = data.azurerm_resource_group.main.name
  name                = "a7exschin.dev"
}

resource "azurerm_dns_a_record" "main" {
  name                = "@"
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = data.azurerm_resource_group.main.name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.main.id
}