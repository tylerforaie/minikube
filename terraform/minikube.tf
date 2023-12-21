provider "minikube" {
  kubernetes_version = "v1.28.3"
}

resource "minikube_cluster" "west" {
  driver            = "docker"
  cluster_name      = "west"
  container_runtime = "docker"
  network_plugin    = "cni"
  addons = [
    "ingress",
    "default-storageclass",
    "storage-provisioner"
  ]
}

resource "minikube_cluster" "east" {
  driver            = "docker"
  cluster_name      = "east"
  container_runtime = "docker"
  network_plugin    = "cni"
  addons = [
    "ingress",
    "default-storageclass",
    "storage-provisioner"
  ]
}
