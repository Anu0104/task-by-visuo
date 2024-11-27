locals {
  gke_version = "1.30.4-gke.1348001"
}

module "utils" {
  source  = "terraform-google-modules/utils/google"
  version = "~> 0.3"
}

module "gke_safer_multi_zonal_cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/safer-cluster-update-variant"
  version = "29.0.0"

  project_id                 = "<PROJECT ID>"
  name                       = "gke-test-1"
  region                     = "us-central1"
  zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network                    = "vpc-01"
  subnetwork                 = "us-central1-01"
  ip_range_pods              = "us-central1-01-gke-01-pods"
  ip_range_services          = "us-central1-01-gke-01-services"
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  dns_cache                  = false

  enable_private_endpoint    = true
  add_cluster_firewall_rules = true

  firewall_inbound_ports = ["8080"]
 
 node_pools = [

     {
      preemptible        = false
      name               = var.gpu_node_pool_config.standard.name
      machine_type       = var.gpu_node_pool_config.standard.machine_type
      node_metadata      = "GKE_METADATA"
      disk_size_gb       = var.gpu_node_pool_config.standard.disk_size_gb
      disk_type          = var.gpu_node_pool_config.standard.disk_type
      image_type         = "COS_CONTAINERD"
      auto_repair        = var.gpu_node_pool_config.standard.auto_repair
      auto_upgrade       = var.gpu_node_pool_config.standard.auto_upgrade
      version            = local.gke_version
      autoscaling        = var.gpu_node_pool_config.standard.autoscaling
      node_count         = var.gpu_node_pool_config.standard.node_count 
      min_count          = var.gpu_node_pool_config.standard.min_count 
      max_count          = var.gpu_node_pool_config.standard.max_count 
      gpu_driver_version = var.gpu_node_pool_config.standard.gpu_driver_version
      accelerator_count  = var.gpu_node_pool_config.standard.accelerator_count
      accelerator_type   = var.gpu_node_pool_config.standard.accelerator_type
      enable_gcfs        = true
    },

 ]

}
