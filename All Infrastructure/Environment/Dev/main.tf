module "My-VPC" {
  source = "../Module"

  key_name  = var.key_name
  instances = var.instances
}
