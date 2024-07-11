resource "azurerm_key_vault" "main" {
  name                = "myKeyVault"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "get",
      "list",
      "set",
      "delete",
      "backup",
      "restore",
    ]
  }
}

resource "azurerm_key_vault_secret" "example" {
  name         = "example-secret"
  value        = "secret-value"
  key_vault_id = azurerm_key_vault.main.id
}
