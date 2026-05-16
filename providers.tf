locals {
  kube_config_path = var.kube_config_path != null ? var.kube_config_path : pathexpand("~/.kube/config")
}

provider "kubernetes" {
  config_path    = var.set_context ? local.kube_config_path : null
  config_context = var.set_context ? var.kube_config_context : null

  host                   = var.set_context ? null : var.kube_host
  token                  = var.set_context ? null : var.kube_token
  cluster_ca_certificate = var.set_context ? null : base64decode(var.kube_cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    config_path    = var.set_context ? local.kube_config_path : null
    config_context = var.set_context ? var.kube_config_context : null

    host                   = var.set_context ? null : var.kube_host
    token                  = var.set_context ? null : var.kube_token
    cluster_ca_certificate = var.set_context ? null : base64decode(var.kube_cluster_ca_certificate)
  }
}
