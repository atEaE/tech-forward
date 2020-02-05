provider "azurerm" {
    version = "~>2.0"
    features {}
}

####################################
### Resource Group
####################################
resource "azurerm_resource_group" "main" {
    name = "${var.name}-rg"
    location = var.location
}

####################################
### Network
####################################
resource "azurerm_virtual_network" "main" {
  name                = "${var.name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

####################################
### Public Subnet
####################################
resource "azurerm_subnet" "subnet" {
  name                 = "${var.name}-internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes       = ["10.0.2.0/24"]
}

####################################
### Internat Gateway
####################################
resource "azurerm_public_ip" "gateway" {
  name                    = "${var.name}-pip"
  location                = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  domain_name_label       = "fids-dev-azure"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.name}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "fidsipc"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.gateway.id
  }
}

####################################
### VM Instance
####################################
resource "azurerm_windows_virtual_machine" "main" {
  name                  = "${var.name}-vm"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  size                  = var.vm_size
  network_interface_ids = [azurerm_network_interface.main.id]
  admin_username        = var.vm_os_profile_adminuser
  admin_password        = var.vm_os_profile_adminpass

  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }
  os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  tags = {
    environment = var.environment
  }
}