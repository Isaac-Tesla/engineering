resource "google_service_account" "dataproc_service_account" {
  account_id   = var.dataproc_sa_id
  display_name = "Dataproc Service Account"
}