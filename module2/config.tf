
variable "tfv" {}
variable "sl" {}


resource "null_resource" "delaymodule2" {
  provisioner "local-exec" {
    command = var.tfv
    interpreter = ["/bin/sleep"]
  }
}

output "version" {
  value = var.tfv
}

output "sleepoutput" {
  value = var.sl
}

