locals {
  login_user = var.tfe_os == "redhat" ? "cloud-user" : "ubuntu"
}

output "ssh_tfe_server" {
  value = "ssh ${local.login_user}@${var.dns_hostname}.${var.dns_zonename}"
}

# output "tfe_instance_public_ip" {
#   value = google_compute_address.tfe-public-ipc.address
# }

output "tfe_appplication" {
  value = "https://${var.dns_hostname}.${var.dns_zonename}"
}
