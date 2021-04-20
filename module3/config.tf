
variable "tfmodule3" {}
variable "slmodule3" {}


resource "null_resource" "delaymodule3" {
  provisioner "local-exec" {
    command = var.tfmodule3
    interpreter = ["/bin/sleep"]
  }
}

output "versionModule3" {
  value = var.tfmodule3
}

output "sleepoutputModule3" {
  value = var.slmodule3
}

output "clusterName" {
  value = "us-central1-a/harness-test"
}
