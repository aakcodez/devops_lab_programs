#Program - 7
## Deploy a Web Application to Kubernetes using Minikube

### Description
This project demonstrates how to deploy a simple web application (Nginx) on a local Kubernetes cluster using Minikube. The aim is to understand the process of creating a Deployment, exposing it through a Service, and accessing the web application running inside Kubernetes pods.

---

### Prerequisites
Make sure you have installed:
- **Minikube:** `https://minikube.sigs.k8s.io/`
- **kubectl:** `https://kubernetes.io/`

---

### Project Structure
```text
Program-7/
├── nginx-deployment.yaml
└── README.md

Step-by-Step Execution Guide
Step 1: Start Minikube
Bash
minikube start

Step 2: Check Minikube Status
Bash
minikube status

Step 3: Expected Status Output
Plaintext
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

Step 4: Reset Minikube (If not running / facing errors)
Bash
minikube delete
minikube start --driver=docker

Step 5: Create a Deployment File (nginx-deployment.yaml)
YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest # already exists on Docker Hub
        ports:
        - containerPort: 80

Step 6: Apply nginx-deployment.yaml
Bash
kubectl apply -f nginx-deployment.yaml

Step 7: Check Status
Bash
kubectl get deployments
kubectl get pods

Step 8: Expose the Deployment as a Service
Bash
kubectl expose deployment nginx-deployment \
  --type=NodePort \
  --port=80

Step 9: Check Service
Bash
kubectl get services

Step 10: Access the Web App
Bash
minikube service nginx-deployment

Step 11: Clean-Up Process (Delete Pods)
Bash
kubectl delete pods --all

Step 12: Delete All Services
Bash
kubectl delete svc --all

Step 13: Delete All Deployments
Bash
kubectl delete deployments --all

Expected Outcomes
-Deploy a containerized web application on a Minikube cluster.

-Expose the application service and verify external accessibility.

-Validate pod creation, scaling, and application response.
EOF
