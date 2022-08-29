sudo yum install -y yum-utils device-mapper-persistent lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y containerd.io-1.2.13 docker-ce-19.03.11 docker-ce-cli-19.03.11
sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
 },
 "storage-driver": "overlay2",
 "storage-opts": [
   "overlay2.override_kernel_check=true"
   ]
}
EOF
sudo mkdir -p /etc/systemd/system/docker.service.d
	sudo systemctl daemon-reload
	systemctl restart docker
	systemctl status docker
	systemctl enable docker
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=0
EOF
sudo yum install -y kubelet-1.23.1 kubeadm-1.23.1 kubectl-1.23.1
sudo systemctl enable --now kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet

