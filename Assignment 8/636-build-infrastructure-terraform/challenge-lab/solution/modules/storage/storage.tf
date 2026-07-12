resource "google_storage_bucket" "storage_bucket" {
  name                        = "tf-bucket-493120"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
}
