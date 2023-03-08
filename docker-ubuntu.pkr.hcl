packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}
# variables precedence: defaults < env vars < var files < cli flags
# run packer on directoruy instead of on template to use var files ('packer build .' instead of packer build 'template.pkr.hcl')
variable "docker_image" {
  type = string
  default = "ubuntu:xenial"
}

source "docker" "ubuntu" {
  image  = var.docker_image
  commit = true
}

build {
  name = "learn-packer"
  sources = [
    "source.docker.ubuntu"
  ]
  provisioner "shell" {
  environment_vars = [
    "FOO=bar",
    "BAZ=qux",
  ]
  inline = [
    "echo 'I hate computers!!!1' > flag.txt",
  ]
  }
  provisioner "shell" {
    inline = ["echo Running ${var.docker_image} image"]
  }
}

