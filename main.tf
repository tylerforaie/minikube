terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.3.6"
    }
  }
}

provider "minikube" {
  kubernetes_version = "v1.28.3"
}

resource "minikube_cluster" "docker" {
  driver       = "docker"
  cluster_name = "terraform-minikube"
}