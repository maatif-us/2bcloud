output "jenkins_public_ip" {
  value = azurerm_public_ip.jenkins_public_ip.ip_address
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "nginx_ingress_ip" {
  value = azurerm_public_ip.nginx_ingress.ip_address
}
