variable "access_key" {
}
variable "secret_key" {
}
variable "tag" {
}
resource "null_resource" "delayawsmodule" {
  provisioner "local-exec" {
    command = var.access_key
    interpreter = ["/bin/sleep"]
  }
}

output "version" {
  value = var.tag
}