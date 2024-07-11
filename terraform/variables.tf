variable "resource_group_name" {
  default = "Muhammad-Candidate"
}

variable "location" {
  default = "East US"
}

variable "jenkins_vm_name" {
  default = "jenkins-server"
}

variable "admin_username" {
  default = "azureuser"
}

variable "admin_password" {
  default = "Azure@2024!" # Use a secure password
}

variable "acr_name" {
  default = "2bcloud"
}

variable "aks_name" {
  default = "2bcloudakscluster"
}

variable "client_id" {
  description = "The Client ID of the Service Principal"
}

variable "client_secret" {
  description = "The Client Secret of the Service Principal"
}

variable "dns_zone_name" {
  default = "example.com" # Replace with your DNS zone
}

variable "dns_zone_resource_group" {
  default = "myDNSResourceGroup" # Replace with your DNS zone resource group
}
