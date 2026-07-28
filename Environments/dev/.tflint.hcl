config {
  format = "compact"
  plugin_dir = "~/.tflint.d/plugins"
}

# Enable the official AzureRM ruleset
plugin "azurerm" {
  enabled = true
  version = "0.27.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}