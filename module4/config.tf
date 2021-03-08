
variable "tfmodule4" {}
variable "slmodule4" {}


resource "null_resource" "delaymodule41" {
  provisioner "local-exec" {
    command = var.tfmodule4
    interpreter = ["/bin/sleep"]
  }
}

output "versionModule4" {
  value = var.tfmodule4
}

output "sleepoutputModule4" {
  value = var.slmodule4
}