packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:xenial"
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
    inline = ["echo this provisioner runs lasts"]
  }
}

