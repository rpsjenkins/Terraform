data "terraform_remote_state" "foo" {
  backend = "azurerm"
  config = {
    storage_account_name = "rpsterraformstorage"
    container_name       = "statefile"
    key                  = "prod.terraform.tfstate"
  }
}

#terraform {
 # backend "azurerm" {
  #  storage_account_name  = "rpsterraformstorage"
   # container_name        = "statefile"
    # key                   = "prod.terraform.tfstate"
 # }
#}

resource "azurerm_resource_group" "main" {
  name     = "RPSResourceGroup"
  location = "var.location"
  }

resource "azurerm_app_service_plan" "main" {
  name                = "var.prefix-asp"
  location            = "azurerm_resource_group.main.location"
  resource_group_name = "azurerm_resource_group.main.name"
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "var.prefix-appservice"
  location            = "azurerm_resource_group.main.location"
  resource_group_name = "azurerm_resource_group.main.name"
  app_service_plan_id = "azurerm_app_service_plan.main.id"

  ## site_config {
  ##   dotnet_framework_version = "v4.0"
  ##   remote_debugging_enabled = true
  ##   remote_debugging_version = "VS2015"
 ##  }
}
