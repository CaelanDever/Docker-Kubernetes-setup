# Maining-Containers-and-setup-Orchestration-2-tasks---Tier-3-and-1-Kubernetes-setup

# Task 1: Setting Up Docker Containers for Web Application Deployment

# 1. Install Docker on CentOS

a. Update the package index:

sudo yum update -y

Explanation: This command updates the package index to ensure you get the latest version of any software you install. The -y flag automatically answers "yes" to any prompts, speeding up the process.

b. Install required packages:

sudo yum install -y yum-utils

Explanation: yum-utils includes utilities that are useful for managing yum repositories and packages, such as yum-config-manager.

c. Add the Docker repository:

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

Explanation: This command adds the Docker repository to your package 
manager. This repository contains the latest Docker packages for CentOS.

<img width="424" alt="doc" src="https://github.com/user-attachments/assets/c63b38c6-46e8-4ca9-994a-0b7a398163fb">


d. Install Docker:

sudo yum install -y docker-ce docker-ce-cli containerd.io

Explanation: This command installs Docker Community Edition (docker-ce), the Docker command-line interface (docker-ce-cli), and containerd, which is 

a core component for container management.

e. Start Docker and enable it to run on startup:

sudo systemctl start docker
sudo systemctl enable docker

Explanation: systemctl start docker starts the Docker service, while systemctl enable docker ensures that Docker starts automatically when the system boots.

<img width="442" alt="csa" src="https://github.com/user-attachments/assets/24dc87e6-773d-4c08-8ff0-2eae801290fe">


f. Verify Docker installation:

sudo docker --version

Explanation: This command checks the Docker version installed on your system, confirming that the installation was successful.

2. Create a Dockerfile

a. Create a directory for your project:

mkdir my_webapp

cd my_webapp

Explanation: This creates a new directory named my_webapp and navigates into it. This directory will contain all the files needed for your Docker image.

b. Create a Dockerfile in this directory:

nano Dockerfile

Explanation: This opens the nano text editor to create and edit a new file named Dockerfile. Dockerfile is a script containing instructions to build a 

Docker image.

<img width="368" alt="olas" src="https://github.com/user-attachments/assets/ab9f9cad-353e-4326-868c-0989d6e33ba1">


c. Add the following content to the Dockerfile:

1. Create the Dockerfile
Create a Directory for Your Docker Project:

bash
Copy code
mkdir webapp
cd webapp
Create a Dockerfile:

Use a text editor to create a file named Dockerfile in the webapp directory.

bash
Copy code
nano Dockerfile
Add the Following Content to the Dockerfile:

This Dockerfile will use an Nginx base image, copy a simple HTML file into the image, and configure Nginx to serve it.

Dockerfile
Copy code
# Use the official Nginx image from the Docker Hub
FROM nginx:alpine

# Copy the static HTML file to the Nginx web root
COPY index.html /usr/share/nginx/html/

# Expose port 80 to the outside world
EXPOSE 80

# The default command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]
Create the HTML File:

Create an index.html file in the same directory.

nano index.html
Add the Content for the Web Application:


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Docker WebApp</title>
</head>
<body>
    <h1>Welcome to the Docker Web Application!</h1>
    <p>This application is served using Docker and Nginx.</p>
    <p>Docker simplifies the deployment and scaling of applications.</p>
    <p>Enjoy exploring Docker!</p>
</body>
</html>

d. Save and exit the editor.

3. Build the Docker Image

a. Build the Docker image using the Dockerfile:


<img width="435" alt="2345" src="https://github.com/user-attachments/assets/65afe3cb-c812-419d-8f8f-7f003787a8d3">


sudo docker build -t my_webapp_image .

Explanation: This command builds a Docker image from the Dockerfile in the current directory. -t my_webapp_image tags the image with the name 
my_webapp_image. The . specifies the build context, which is the current directory.

# 4. Run the Docker Container

a. Run a Docker container using the built image:

sudo docker run -d --name webapp_container -p 80:3000 my_webapp_image

Explanation:

-d: Runs the container in detached mode, meaning it runs in the background.

--name webapp_container: Assigns the name webapp_container to the container for easy reference.


my_webapp_image: Specifies the image to use for the container.

# 5. Verify the Container is Running

a. Check the running containers:

sudo docker ps

Explanation: Lists all running containers. Verify that webapp_container is listed and check the mapped ports.

b. Open a web browser and navigate to your CentOS server's IP address or domain name.

Explanation: Open your web browser and go to http://<your_server_ip> or http://<your_domain>. You should see your web application if everything is set up correctly.

c. Inspect logs for troubleshooting (if needed):

sudo docker logs webapp_container

Explanation: Displays the logs from webapp_container. Useful for debugging if the application isn’t behaving as expected.

d. To stop and remove the container (if needed):

sudo docker stop webapp_container

sudo docker rm webapp_container

Explanation: docker stop stops the running container, and docker rm removes it. This is useful for cleanup or if you need to start a new container.


<img width="441" alt="132" src="https://github.com/user-attachments/assets/f7eb3318-a35a-48a2-b935-23b41b677df3">


e. To remove the Docker image (if needed):

sudo docker rmi my_webapp_image

Explanation: Removes the Docker image named my_webapp_image from your system. This is useful for freeing up space or if you no longer need the image.

# Summary

By following these steps, you install Docker, create a Dockerfile for your web application, build a Docker image, run a container from that image, and verify that the application is accessible through the server’s IP address or domain.

Dockerfile:

Dockerfile

FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
index.html:


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Docker WebApp</title>
</head>
<body>
    <h1>Welcome to the Docker Web Application!</h1>
    <p>This application is served using Docker and Nginx.</p>
    <p>Docker simplifies the deployment and scaling of applications.</p>
    <p>Enjoy exploring Docker!</p>
</body>
</html>
Build and Run Commands:

docker build -t your_image_name .

docker run -d --name webapp_container -p 8080:80 your_image_name

This will set up a Docker container that serves a simple web page with information about Docker. Let me know if you need any more help!

# =============================================================================================================================================================================Task 2: Building Kubernetes from Scratch

Building Kubernetes from scratch is a complex task but is a valuable learning experience. Below is a detailed guide to set up a Kubernetes cluster from scratch, focusing on the key components: etcd, kube-apiserver, kube-scheduler, kube-controller-manager, and kubelet.

Prerequisites

CentOS 8: Ensure you have a clean CentOS 8 installation.

Minimum Requirements: At least 2GB of RAM and 2 CPUs per node.

Network Configuration: Ensure your network allows communication between nodes.

1. Prepare the Environment

a. Install Required Packages:

sudo dnf install -y wget curl vim net-tools

b. Disable Swap: Kubernetes requires swap to be disabled.

sudo swapoff -a

To disable swap permanently, remove or comment out the swap entry in /etc/fstab.

c. Configure the Firewall: Allow necessary ports for Kubernetes components.

sudo firewall-cmd --permanent --add-port=6443/tcp
sudo firewall-cmd --permanent --add-port=2379-2380/tcp
sudo firewall-cmd --permanent --add-port=10250/tcp
sudo firewall-cmd --permanent --add-port=10251/tcp
sudo firewall-cmd --permanent --add-port=10252/tcp
sudo firewall-cmd --permanent --add-port=10255/tcp
sudo firewall-cmd --reload

<img width="449" alt="15" src="https://github.com/user-attachments/assets/a5de0da2-be64-4b08-b0aa-ed375e6054d7">


d. Set SELinux to Permissive Mode:


sudo setenforce 0
To make this change permanent, modify the /etc/selinux/config file and set SELINUX=permissive.

# 2. Install and Configure ETCD
a. Download and Install ETCD:

wget https://github.com/etcd-io/etcd/releases/download/v3.5.0/etcd-v3.5.0-linux-amd64.tar.gz
tar xzvf etcd-v3.5.0-linux-amd64.tar.gz
sudo mv etcd-v3.5.0-linux-amd64/etcd* /usr/local/bin/
b. Create ETCD Data Directory:

sudo mkdir -p /var/lib/etcd

<img width="455" alt="1243" src="https://github.com/user-attachments/assets/91161f0a-d15b-4063-aa14-9429ea8062c1">

c. Start ETCD: Create an etcd service file:

sudo vim /etc/systemd/system/etcd.service
Add the following content:

[Unit]
Description=etcd
Documentation=https://etcd.io/docs/
After=network.target

[Service]
ExecStart=/usr/local/bin/etcd \
  --name=$(hostname) \
  --data-dir=/var/lib/etcd \
  --listen-peer-urls=http://0.0.0.0:2380 \
  --listen-client-urls=http://0.0.0.0:2379 \
  --advertise-client-urls=http://<Server-IP>:2379 \
  --initial-advertise-peer-urls=http://<Server-IP>:2380 \
  --initial-cluster-token=etcd-cluster-1 \
  --initial-cluster=$(hostname)=http://<Server-IP>:2380 \
  --initial-cluster-state=new
Restart=always


<img width="355" alt="86" src="https://github.com/user-attachments/assets/81c98890-0869-4861-8740-a780a9221946">

[Install]
WantedBy=multi-user.target
Replace <Server-IP> with the IP address of your server. (I did this.)

Start and enable 
ETCD:

sudo systemctl daemon-reload
sudo systemctl start etcd
sudo systemctl enable etcd

<img width="451" alt="213" src="https://github.com/user-attachments/assets/f4b57bce-89b9-4f4c-ae89-f0cc872c0050">


3. Install and Configure Kubernetes Components
a. Download and Install Kubernetes Binaries:

wget https://dl.k8s.io/v1.26.0/kubernetes-server-linux-amd64.tar.gz
tar xzvf kubernetes-server-linux-amd64.tar.gz
sudo mv kubernetes/server/bin/* /usr/local/bin/

<img width="444" alt="421" src="https://github.com/user-attachments/assets/6863a7fb-8cb9-404e-a969-7c548282d38c">


b. Configure the Kube-apiserver: Create a kube-apiserver service file:

sudo vim /etc/systemd/system/kube-apiserver.service
Add the following content:

[Unit]
Description=Kubernetes API Server
Documentation=https://kubernetes.io/docs/
After=network.target

[Service]
ExecStart=/usr/local/bin/kube-apiserver \
  --advertise-address=<Server-IP> \
  --allow-privileged=true \
  --apiserver-count=1 \
  --etcd-servers=http://127.0.0.1:2379 \
  --service-cluster-ip-range=10.96.0.0/12 \
  --network-plugin=cni \
  --kubelet-client-certificate=/etc/kubernetes/ssl/kube-apiserver.pem \
  --kubelet-client-key=/etc/kubernetes/ssl/kube-apiserver-key.pem \
  --client-ca-file=/etc/kubernetes/ssl/ca.pem \
  --tls-cert-file=/etc/kubernetes/ssl/kube-apiserver.pem \
  --tls-private-key-file=/etc/kubernetes/ssl/kube-apiserver-key.pem
Restart=always

<img width="430" alt="kub" src="https://github.com/user-attachments/assets/89ba5624-6b43-4d3c-90b2-fcee05e83a9b">


[Install]
WantedBy=multi-user.target
Replace <Server-IP> with the IP address of your server. Start and enable kube-apiserver:

sudo systemctl daemon-reload
sudo systemctl start kube-apiserver
sudo systemctl enable kube-apiserver

c. Configure the Kube-controller-manager: Create a kube-controller-manager service file:

sudo vim /etc/systemd/system/kube-controller-manager.service
Add the following content:

[Unit]
Description=Kubernetes Controller Manager
Documentation=https://kubernetes.io/docs/
After=network.target

[Service]
ExecStart=/usr/local/bin/kube-controller-manager \
  --master=http://<Server-IP>:6443 \
  --kubeconfig=/etc/kubernetes/controller-manager.conf \
  --service-account-private-key-file=/etc/kubernetes/ssl/ca-key.pem \
  --root-ca-file=/etc/kubernetes/ssl/ca.pem \
  --cluster-cidr=10.244.0.0/16 \
  --allocate-node-cidrs=true \
  --cloud-provider=external
Restart=always

[Install]
WantedBy=multi-user.target

<img width="421" alt="90" src="https://github.com/user-attachments/assets/f918dd81-6182-4790-a2fa-4ccf1cc40186">

Start and enable kube-controller-manager:

sudo systemctl daemon-reload
sudo systemctl start kube-controller-manager
sudo systemctl enable kube-controller-manager

<img width="454" alt="321" src="https://github.com/user-attachments/assets/bd949a41-27ad-4864-97c2-8df908f1c014">


d. Configure the Kube-scheduler: Create a kube-scheduler service file:

sudo vim /etc/systemd/system/kube-scheduler.service
Add the following content:

[Unit]
Description=Kubernetes Scheduler
Documentation=https://kubernetes.io/docs/
After=network.target

[Service]
ExecStart=/usr/local/bin/kube-scheduler \
  --master=http://<Server-IP>:6443 \
  --kubeconfig=/etc/kubernetes/scheduler.conf
Restart=always

[Install]
WantedBy=multi-user.target

<img width="295" alt="money" src="https://github.com/user-attachments/assets/1c9c0963-ec81-4efe-bbda-0e1425f870db">

Start and enable kube-scheduler:

sudo systemctl daemon-reload
sudo systemctl start kube-scheduler
sudo systemctl enable kube-scheduler
e. Configure the Kubelet: The kubelet should be installed on each node and configured to communicate with the API server. For simplicity, the kubelet’s configuration will be included in the following steps.

<img width="298" alt="66" src="https://github.com/user-attachments/assets/86faa1cc-306e-4fe0-9cc9-a72058b65ac2">


# 4. Install and Configure kubectl
a. Install kubectl:

wget https://dl.k8s.io/v1.26.0/kubernetes-client-linux-amd64.tar.gz
tar xzvf kubernetes-client-linux-amd64.tar.gz
sudo mv kubernetes/client/bin/kubectl /usr/local/bin/

# 5. Verify the Cluster
a. Check Nodes:


kubectl get nodes
Expected Output: If successful, you’ll see your node listed. If not successful, you may get a connection error or refused connection message.
b. Troubleshoot Errors:

Check Component Statuses:

sudo systemctl status kube-apiserver
sudo systemctl status kube-controller-manager
sudo systemctl status kube-scheduler

Check Logs:

sudo journalctl -u kube-apiserver
sudo journalctl -u kube-controller-manager
sudo journalctl -u kube-scheduler

Verify Configuration Files: Ensure all configuration files and certificates are correctly set up and accessible by the Kubernetes components.

Resources
Kubernetes Documentation: For detailed instructions on configuring each component.


Server World: Server World - Kubernetes Installation for additional guidance.


This guide should provide a solid foundation for setting up Kubernetes from scratch. Adjust configurations and paths according to your specific setup and requirements.







