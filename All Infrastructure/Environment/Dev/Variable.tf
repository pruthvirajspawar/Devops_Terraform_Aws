variable "key_name" {
  type = string
}

variable "instances" {
  type = map(object({
    ami           = string
    instance_type = string
    name          = string
  }))
}