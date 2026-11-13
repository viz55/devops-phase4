resource "terraform_data" "protected" {
  input = "critical resource"

  lifecycle {
    prevent_destroy = false
  }
}
