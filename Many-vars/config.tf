variable "var1" {}
variable "var2" {}
variable "var3" {}
variable "var4" {}





resource "local_file" "foo" {
  content     = "foo!"
  filename = "${path.module}/foo.bar"
}

output "output1" {
  value = var.var1
}

output "output2" {
  value = var.var2
}

output "output3" {
  value = var.var3
}

output "output4" {
  value = var.var4
}