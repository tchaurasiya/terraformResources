resource "local_file" "foomodule1" {
    content     = "foo1!"
    filename = "${path.module}/foo1.bar"
}
