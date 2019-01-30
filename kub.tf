resource "digitalocean_kubernetes_cluster" "dokub2" {
  name    = "dokub2"
  region  = "ams3"
  version = "1.13.1-do.2"
  tags    = ["test"]

  node_pool {
    name       = "small-pool"
    size       = "s-1vcpu-2gb"
    node_count = 1
  }
}

provider "kubernetes" {
  host = "${digitalocean_kubernetes_cluster.dokub2.endpoint}"

  client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.dokub2.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(digitalocean_kubernetes_cluster.dokub2.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.dokub2.kube_config.0.cluster_ca_certificate)}"
}

resource "kubernetes_pod" "resnet" {
  metadata {
    name = "resnet-score"
    labels {
      App = "resnet"
    }
  }

  spec {
    container {
      image = "gbaeke/onnxresnet50v2"
      name  = "resnet"

      port {
        container_port = 5001
      }
    }
  }
}

resource "kubernetes_service" "resnet" {
  metadata {
    name = "resnet"
  }
  spec {
    selector {
      App = "${kubernetes_pod.resnet.metadata.0.labels.App}"
    }
    port {
      port = 80
      target_port = 5001
    }

    type = "LoadBalancer"
  }
}


output "lb" {
  value = "${kubernetes_service.resnet.load_balancer_ingress.0.ip}"
}
