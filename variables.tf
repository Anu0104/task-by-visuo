variable "gpu_node_pool_config" {
  description = "The node pool configuration of ray-head."
  type = object({
    standard = object({
      name               = string
      machine_type       = string
      disk_size_gb       = number
      disk_type          = string
      auto_repair        = string
      auto_upgrade       = string
      autoscaling        = bool
      node_count         = number
      min_count          = number
      max_count          = number
      accelerator_type   = string
      accelerator_count  = number
      gpu_driver_version = string
    })
  })
  default = {
    standard = {
      name               = "gpu-nodes"
      machine_type       = "g2-standard-4"
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      auto_repair        = true
      auto_upgrade       = false
      autoscaling        = true
      node_count         = 1
      min_count          = 1
      max_count          = 2
      accelerator_type   = "nvidia-tesla-t4"
      accelerator_count  = 1
      gpu_driver_version = "LATEST"
    }
}
}
