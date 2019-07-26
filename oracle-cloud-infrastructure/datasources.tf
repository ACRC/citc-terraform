# Gets a list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

data "tls_public_key" "oci_public_key" {
  private_key_pem = "${file(var.private_key_path)}"
}

data "template_file" "user_data" {
  template = "${file(var.BootStrapFile)}"

  vars {
    ansible_branch = "${var.ansible_branch}",
    cloud-platform = "oci",
    fileserver-ip  = "" # the file server is determined via a static name on OCI
  }
}