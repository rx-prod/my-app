provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

locals {
  namespace = "argocd"
}

resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = local.namespace
  create_namespace = true
  version          = "5.52.0"

  values = [file("${path.module}/values/argocd.yaml")]
}

resource "kubernetes_manifest" "apps" {
  manifest = yamldecode(file("${path.module}/manifests/my-app.yaml"))
}

data "kubernetes_resource" "argo_password" {
  api_version = "v1"
  kind        = "Secret"

  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = local.namespace
  }
}

output "argo_password" {
  value = base64decode(data.kubernetes_resource.argo_password.object.data.password)
}
