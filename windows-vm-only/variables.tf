####################################
### Grobal Setting
####################################
variable "environment" {
  description = "作成する環境を指定してください。"
  type        = string
  default     = "development"
}

####################################
### Location
####################################
variable "location" {
  description = "Azure ResourceGroupが管理されるRegion"
  type        = string
}

####################################
### Resource Group
####################################
variable "name" {
  description = "Azureのリソースタグ名"
  type        = string
}

####################################
### VM Instance
####################################
variable "vm_size" {
  description = "VMのインスタンスサイズ"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "vm_image_publisher" {
  description = "VMイメージの発行元を指定してください。"
  type        = string
  default     = "MicrosoftWindowsServer"
}

variable "vm_image_offer" {
  description = "VMイメージが提供するOS機能を指定してください。"
  type        = string
  default     = "WindowsServer"
}

variable "vm_image_sku" {
  description = "VMイメージが提供するOSのタイプを指定してください。"
  type        = string
  default     = "2016-Datacenter"
}

variable "vm_image_version" {
  description = "VMイメージが提供するOSのVersionを指定してください。"
  type        = string
  default     = "latest"
}

variable "vm_os_profile_hostname" {
  description = "VMOSのホスト名を指定してください。"
  type        = string
  default     = "vinci-srv"
}

variable "vm_os_profile_adminuser" {
  description = "VMOSの管理者名を指定してください。"
  type        = string
}

variable "vm_os_profile_adminpass" {
  description = "VMOSの管理者パスワードを指定してください。"
  type        = string
}