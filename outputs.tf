output "argocd_namespace" {
  description = "Namespace where ArgoCD is deployed"
  value       = var.argocd_namespace
}

output "argocd_server_service" {
  description = "Name of the ArgoCD server service"
  value       = "argocd-server"
}

output "argocd_helm_chart_version" {
  description = "Version of the deployed ArgoCD Helm chart"
  value       = var.argocd_helm_chart_version
}

output "get_admin_password" {
  description = "Command to retrieve the ArgoCD admin password"
  value       = "kubectl -n ${var.argocd_namespace} get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d && echo"
}

output "port_forward_command" {
  description = "Command to port-forward the ArgoCD server"
  value       = "kubectl port-forward -n ${var.argocd_namespace} svc/argocd-server 8080:443"
}

output "argocd_server_url" {
  description = "URL to access the ArgoCD server (if ingress is enabled)"
  value       = var.ingress_enabled ? "https://${var.ingress_host}" : null
}
