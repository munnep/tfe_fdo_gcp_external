resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.certificate_email
}


resource "acme_certificate" "certificate" {
  account_key_pem = acme_registration.registration.account_key_pem
  common_name     = "${var.dns_hostname}.${var.dns_zonename}"

  dns_challenge {
    provider = "gcloud"

    config = {
      GCE_PROJECT = var.gcp_project
    }
  }
}



resource "google_dns_record_set" "tfe" {
  name = "${var.dns_hostname}.${var.dns_zonename}."
  type = "A"
  ttl  = 300

  managed_zone = "doormat-accountid"

  rrdatas = [google_compute_address.tfe-public-ipc.address]
  

  depends_on = [
    google_compute_address.tfe-public-ipc
  ]
}
