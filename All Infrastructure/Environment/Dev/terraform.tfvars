key_name = "Shree"

instances = {
  server1 = {
    ami           = "ami-0011550b539717e2a"
    instance_type = "t3.micro"
    name          = "Dev-Server"
  }

  server2 = {
    ami           = "ami-0e38835daf6b8a2b9"
    instance_type = "t3.micro"
    name          = "Prod-Server"
  }
}