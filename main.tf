provider "aws" {
  region = "us-east-2"
}

data "terraform_remote_state" "networking_stuff" {
  backend = "remote"

  config = {
    organization = "andys-fake-company"

    workspaces {
      name = "Network-Team"
    }
  }
}
data "terraform_remote_state" "security_stuff" {
  backend = "remote"

  config = {
    organization = "andys-fake-company"

    workspaces {
      name = "Security-Team"
    }
  }
}
resource "aws_instance" "jenkins-server" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t3.small"
  key_name = "ajames-key"
  vpc_security_group_ids = ["${data.terraform_remote_state.security_stuff.fakecompany_sharedservices_security_group_id}"]
  connection {
        user = "centos"
        type = "ssh"
        private_key = "${file("/Users/andy/.ssh/ajames_aws")}"
        timeout = "2m"
  }
  provisioner "file" {
    source      = "bash"
    destination = "/tmp"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/bash/*",
      "sudo /tmp/bash/jenkins-installer.sh",
      "sudo /tmp/bash/jenkins-admin.sh",
    ]
  }
  tags = {
    Name = "jenkins-server"
    TTL = "72"
    owner = "Andy James"
  }
}

resource "aws_instance" "vault-server" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t3.small"
  key_name = "ajames-key"
  vpc_security_group_ids = ["${data.terraform_remote_state.security_stuff.fakecompany_sharedservices_security_group_id}"]
  connection {
        user = "centos"
        type = "ssh"
        private_key = "${file("/Users/andy/.ssh/ajames_aws")}"
        timeout = "2m"
  }
  provisioner "file" {
    source      = "bash"
    destination = "/tmp"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/bash/*",
      "sudo /tmp/bash/vault-installer.sh",
      "sudo /tmp/bash/vault-admin.sh",
    ]
  }
  tags = {
    Name = "vault-server"
    TTL = "72"
    owner = "Andy James"
  }
}
