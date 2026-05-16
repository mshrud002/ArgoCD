resource "kubernetes_namespace" "argocd" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.argocd_namespace
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = var.argocd_helm_repo
  chart            = var.argocd_chart_name
  namespace        = var.argocd_namespace
  version          = var.argocd_helm_chart_version
  create_namespace = !var.create_namespace
  wait             = var.wait_for_deploy
  timeout          = 600
  max_history      = 3
  skip_crds        = false

  values = [
    templatefile(var.argocd_values_file, {
      ingress_enabled      = var.ingress_enabled
      ingress_class_name   = var.ingress_class_name
      ingress_host         = var.ingress_host
      ingress_annotations  = var.ingress_annotations
      tls_enabled          = var.tls_enabled
      redis_ha_enabled     = var.redis_ha_enabled
    })
  ]

  dynamic "set" {
    for_each = var.additional_helm_sets
    content {
      name  = split("=", set.value)[0]
      value = split("=", set.value)[1]
    }
  }

  set {
    name  = "server.replicas"
    value = var.server_deployment_replicas
  }

  set {
    name  = "repoServer.replicas"
    value = var.repo_server_replicas
  }

  set {
    name  = "controller.replicas"
    value = var.application_controller_replicas
  }

  set {
    name  = "redis-ha.enabled"
    value = var.redis_ha_enabled
  }

  dynamic "set" {
    for_each = var.configs_cm
    content {
      name  = "configs.cm.${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.configs_rbac_cm
    content {
      name  = "configs.rbac.${set.key}"
      value = set.value
    }
  }

  depends_on = [kubernetes_namespace.argocd]
}
