provider "flux" {
  alias = "west-flux"
  kubernetes = {
    host                   = minikube_cluster.west.host
    client_certificate     = minikube_cluster.west.client_certificate
    client_key             = minikube_cluster.west.client_key
    cluster_ca_certificate = minikube_cluster.west.cluster_ca_certificate
  }
  git = {
    url = "ssh://git@github.com/${var.github_org}/${var.github_repository}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

provider "flux" {
  alias = "east-flux"
  kubernetes = {
    host                   = minikube_cluster.east.host
    client_certificate     = minikube_cluster.east.client_certificate
    client_key             = minikube_cluster.east.client_key
    cluster_ca_certificate = minikube_cluster.east.cluster_ca_certificate
  }
  git = {
    url = "ssh://git@github.com/${var.github_org}/${var.github_repository}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

resource "flux_bootstrap_git" "west" {
  provider   = flux.west-flux
  depends_on = [github_repository_deploy_key.this]

  path = "clusters/west"
}

resource "flux_bootstrap_git" "east" {
  provider   = flux.east-flux
  depends_on = [github_repository_deploy_key.this]

  path = "clusters/east"
}
