resource "google_dataproc_cluster" "dataproc_cluster" {
  name     = "${var.environment}cluster"
  region   = var.region
  graceful_decommission_timeout = "120s"
  labels = {
    Environment = "${var.environment}"
  }

  cluster_config {
    staging_bucket = "dataproc-staging-bucket"

    master_config {
      num_instances = 1
      machine_type  = "e2-medium"
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 30
      }
    }

    worker_config {
      num_instances    = 2
      machine_type     = "e2-medium"
      min_cpu_platform = "Intel Skylake"
      disk_config {
        boot_disk_size_gb = 30
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    software_config {
      image_version = "2.0.27-deb10"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }

    gce_cluster_config {
      tags = ["${var.environment}"]
      service_account = google_service_account.dataproc_service_account.email
      service_account_scopes = [
        "cloud-platform"
      ]
    }

    initialization_action {
      script      = "gs://dataproc-initialization-actions/stackdriver/stackdriver.sh"
      timeout_sec = 600
    }
  }
}