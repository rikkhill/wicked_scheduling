provider "google" {
  project = "wicked-scheduling"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_bucket" "scheduled-jobs" {
  name = "scheduled-jobs"
}

data "archive_file" "job" {
  type = "zip"
  source_file = "../scripts/index.js"
  output_path = "output/index.zip"
}

resource "google_storage_bucket_object" "job-archive" {
  name   = "index.zip"
  bucket = "${google_storage_bucket.scheduled-jobs.name}"
  source = "./output/index.zip"
}

resource "google_cloudfunctions_function" "job" {
  name                  = "job"
  description           = "job"
  available_memory_mb   = 128
  source_archive_bucket = "${google_storage_bucket.scheduled-jobs.name}"
  source_archive_object = "${google_storage_bucket_object.job-archive.name}"
  trigger_http          = true
  timeout               = 60
  entry_point           = "yo"
}
