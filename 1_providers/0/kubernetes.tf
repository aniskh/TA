locals {
  pod_memory = "340Mi"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "my-first-namespace"
  }
}

resource "kubernetes_deployment" "nginx" {
  timeouts {
    create = "60m"
  }
  metadata {
    name = "scalable-nginx-example"
    labels = {
      App = "ScalableNginxExample"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableNginxExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableNginxExample"
        }
      }
      spec {
        container {
          image = "nginx:latest"
          name  = "example"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "${local.pod_memory}"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }


        }
      }
    }
  }
}