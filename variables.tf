variable "argocd_namespace" {
  description = "Namespace to deploy ArgoCD into"
  type        = string
  default     = "argocd"
}

variable "argocd_helm_chart_version" {
  description = "Version of the ArgoCD Helm chart"
  type        = string
  default     = "7.7.16"
}

variable "argocd_helm_repo" {
  description = "Helm repository for ArgoCD"
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "argocd_chart_name" {
  description = "Helm chart name for ArgoCD"
  type        = string
  default     = "argo-cd"
}

variable "argocd_values_file" {
  description = "Path to a custom values.yaml file for ArgoCD Helm chart"
  type        = string
  default     = "values.yaml"
}

variable "create_namespace" {
  description = "Whether to create the namespace for ArgoCD"
  type        = bool
  default     = true
}

variable "ingress_enabled" {
  description = "Enable ingress for ArgoCD server"
  type        = bool
  default     = false
}

variable "ingress_host" {
  description = "Hostname for the ArgoCD ingress"
  type        = string
  default     = "argocd.example.com"
}

variable "ingress_class_name" {
  description = "Ingress class name"
  type        = string
  default     = "traefik"
}

variable "ingress_annotations" {
  description = "Annotations for the ingress resource"
  type        = map(string)
  default = {
    "traefik.ingress.kubernetes.io/router.entrypoints" = "websecure"
    "cert-manager.io/cluster-issuer"                   = "letsencrypt-prod"
  }
}

variable "tls_enabled" {
  description = "Enable TLS for ingress"
  type        = bool
  default     = false
}

variable "tls_secret_name" {
  description = "Name of the TLS secret"
  type        = string
  default     = "argocd-tls"
}

variable "configs_cm" {
  description = "Additional ArgoCD ConfigMap settings"
  type        = map(string)
  default     = {}
}

variable "configs_rbac_cm" {
  description = "Additional ArgoCD RBAC ConfigMap settings"
  type        = map(string)
  default     = {}
}

variable "server_deployment_replicas" {
  description = "Number of ArgoCD server replicas"
  type        = number
  default     = 1
}

variable "repo_server_replicas" {
  description = "Number of ArgoCD repo server replicas"
  type        = number
  default     = 1
}

variable "application_controller_replicas" {
  description = "Number of ArgoCD application controller replicas"
  type        = number
  default     = 1
}

variable "redis_ha_enabled" {
  description = "Enable Redis HA (high-availability) mode"
  type        = bool
  default     = false
}

variable "set_context" {
  description = <<-EOT
    Automatically detect and use the current kubectl context.
    Set to false if you configure the kubernetes provider yourself.
  EOT
  type        = bool
  default     = true
}

variable "kube_config_context" {
  description = "Kubectl context to use (if set_context is true)"
  type        = string
  default     = null
}

variable "kube_config_path" {
  description = "Path to the kube config file"
  type        = string
  default     = null
}

variable "kube_host" {
  description = "Kubernetes API host (only used if set_context is false)"
  type        = string
  default     = null
}

variable "kube_token" {
  description = "Kubernetes API token (only used if set_context is false)"
  type        = string
  default     = null
  sensitive   = true
}

variable "kube_cluster_ca_certificate" {
  description = "Kubernetes API CA certificate (only used if set_context is false)"
  type        = string
  default     = null
}

variable "additional_helm_sets" {
  description = "Additional Helm set values (list of key=value)"
  type        = list(string)
  default     = []
}

variable "argocd_initial_admin_password" {
  description = "Initial admin password for ArgoCD (auto-generated if empty)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "wait_for_deploy" {
  description = "Wait for ArgoCD pods to be ready"
  type        = bool
  default     = true
}
