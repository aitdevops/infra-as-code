provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
}

resource "helm_release" "ingress-nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
}

resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  version          = "v1.15.3"

  set {
    name  = "crds.enabled"
    value = "true"
  }

  timeout          = 300 # Timeout in seconds
  wait             = true  # Wait for resources to be ready
}

resource "null_resource" "patch_argocd_service" {
  depends_on = [helm_release.argocd]

   provisioner "local-exec" {
    command = <<EOT
    sleep 30  # Wait for the LoadBalancer IP to be assigned
    kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].ip}' > /tmp/argocd_lb_ip.txt
    EOT
  }
}