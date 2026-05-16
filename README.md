# ArgoCD

Deploy ArgoCD to any Kubernetes cluster using Terraform.

## Prerequisites

- Terraform >= 1.3
- `kubectl` configured with access to a Kubernetes cluster
- Helm CLI (optional, for troubleshooting)

## Quick Start

```bash
# 1. Copy the example vars and customize
cp terraform.tfvars.example terraform.tfvars

# 2. Initialize Terraform
terraform init

# 3. Review the plan
terraform plan

# 4. Deploy ArgoCD
terraform apply -auto-approve
```

## Configuration

### Kubernetes Context

**Option A: Auto-detect from kubeconfig (default)**

Set `set_context = true` and optionally specify a context:

```hcl
set_context       = true
kube_config_context = "my-cluster"   # omit to use current context
```

**Option B: Explicit credentials (any K8s cluster)**

Set `set_context = false` and provide the API endpoint:

```hcl
set_context                 = false
kube_host                   = "https://api.my-cluster.com:6443"
kube_token                  = "..."     # service account token
kube_cluster_ca_certificate = "..."     # base64-encoded CA cert
```

This works with **any Kubernetes distribution**:
- Local: Minikube, Kind, K3s, MicroK8s
- Cloud: EKS, AKS, GKE, OKE
- On-prem: OpenShift, Rancher, Vanilla K8s

### Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `argocd_namespace` | `argocd` | Namespace to deploy into |
| `argocd_helm_chart_version` | `7.7.16` | Helm chart version |
| `ingress_enabled` | `false` | Enable ingress |
| `ingress_host` | `argocd.example.com` | Ingress hostname |
| `server_deployment_replicas` | `1` | Server replicas |
| `wait_for_deploy` | `true` | Wait for pods ready |

## Post-Deployment

Retrieve the admin password:

```bash
terraform output get_admin_password
```

Port-forward to access the UI:

```bash
terraform output port_forward_command
```

Open https://localhost:8080 and login as `admin`.

## Destroy

```bash
terraform destroy -auto-approve
```
