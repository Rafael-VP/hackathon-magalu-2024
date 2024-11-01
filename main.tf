terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
    }
  }
}

provider "mgc" {
  alias = "teste"
  region = "br-ne1"
  api_key = "api_key"
  object_storage = {
    key_pair = {
      key_id = "key_id"
      key_secret = "key_secret"
    }
  }
}


# Create a VM and associate a Public IP
resource "mgc_virtual_machine_instances" "placeholder" {
  provider = mgc
  name     = "placeholder"
  machine_type = {
    name = "cloud-bs1.xsmall"
  }
  image = {
    name = "cloud-ubuntu-22.04 LTS"
  }
  network = {
    associate_public_ip = true
    delete_public_ip    = true # We specify that when this VM is deleted, the public IP should be deleted as well.
  }

  ssh_key_name = "placeholder-01"
}

# Create a vm and execute provisioner
#resource "mgc_virtual_machine_instances" "T04-provisioner" {
#  name = "basic_instance_using-provisioner"
#  machine_type = {
#    name = "cloud-bs1.xsmall"
#  }
#  image = {
#    name = "cloud-ubuntu-22.04 LTS"
#  }
#  network = {
#    associate_public_ip = true # If true, will create a public IP
#    delete_public_ip = true
#    interface = {
#      security_groups = [{ "id" : "rw2r4123-e961-4916-b282-113123123" }]
#    }
#  }
#  
#  ssh_key_name = "placeholder-01"
#  
#  provisioner "file" {
#    source      = "hello.txt"
#    destination = "/tmp/hello.txt"
#  }
#  provisioner "remote-exec" {
#    inline = [
#      "chmod +x /tmp/hello.txt",
#      "ls -l /tmp/hello.txt"
#    ]
#  }
#  connection {
#      type        = "ssh"
#      user        = "ubuntu"
#      private_key = file("~/projects/hackathon-magalu-2024/id_rsa")
#      host        = self.network.public_address
#    }
#}

