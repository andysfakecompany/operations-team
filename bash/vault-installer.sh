cd /opt/
sudo yum -y install unzip wget
sudo wget https://releases.hashicorp.com/vault/1.1.2/vault_1.1.2_linux_amd64.zip
sudo unzip vault_1.1.2_linux_amd64.zip -d .
sudo cp vault /usr/bin/
sudo mkdir /etc/vault
sudo mkdir /vault-data
sudo mkdir -p /logs/vault/
sudo cp /tmp/bash/configs/vault.json /etc/vault/config.json
sudo cp /tmp/bash/configs/vault.service /etc/systemd/system/vault.service
sudo systemctl start vault.service
sudo systemctl status vault.service
sudo systemctl enable vault.service
export VAULT_ADDR=http://localhost:8200
echo "export VAULT_ADDR=http://localhost:8200" >> ~/.bashrc
echo "export VAULT_ADDR=http://localhost:8200" >> /home/centos/.bashrc
