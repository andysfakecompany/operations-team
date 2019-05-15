output "jenkins_server" {
  value = "http://${aws_instance.jenkins-server.public_ip}:8080"
}
output "vault_server" {
  value = "http://${aws_instance.vault-server.public_ip}:8200"
}
