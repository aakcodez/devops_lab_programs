cd ~/Documents/3rd\ sem/Devops/devops_lab_programs
mkdir -p Program-8 Program-8-nodejs

# 1. Create README.md for Program-8 (Python Pod Version)
cat << 'EOF' > Program-8/README.md
# Program - 8
## Create Kubernetes Pods using YAML Descriptors (Python Implementation)

### Description
This project demonstrates how to create, inspect, and interact with a standalone Kubernetes Pod using a declarative YAML manifest generated via `kubectl` dry-run commands.

---

### Prerequisites
- **Minikube**
- **kubectl**
- **Docker**

---

### Project Structure
```text
Program-8/
├── python-pod.yaml
└── README.md

Step-by-Step Execution Guide
Step 1: Start Minikube & Check Status
Bash

minikube start
minikube status

Step 2: Generate python-pod.yaml via Dry-Run
Bash

kubectl run python-pod \
  --image=python:3.12-slim \
  --restart=Never \
  --dry-run=client -o yaml \
  --command -- python -u -c "import time; print('Welcome to Kubernetes!'); print('Python Pod is running'); time.sleep(3600)" \
  > python-pod.yaml

Step 3: Deploy the Pod & Verify Status
Bash

kubectl apply -f python-pod.yaml
kubectl get pods

(Wait until STATUS shows Running, then check the startup logs.)
Bash

kubectl logs python-pod

Step 4: Execute Python Commands Inside the Pod
Bash

# Check Python version
kubectl exec -it python-pod -- python --version

# Open interactive Python shell (type exit() to return)
kubectl exec -it python-pod -- python

# Run inline print statement
kubectl exec -it python-pod -- python -c "print('Hello Students!')"

# Run inline calculation
kubectl exec -it python-pod -- python -c "a=10; b=20; print('Sum =', a+b)"

Step 5: Clean-Up Process
Bash

kubectl delete -f python-pod.yaml

Expected Outcomes

    Declaratively create and deploy a standalone Kubernetes Pod using a YAML descriptor.

    Verify container logs and execute commands inside a running Pod using kubectl exec.
    EOF

2. Create README.md for Program-8-nodejs (Manual Node.js + ConfigMap Version)

cat << 'EOF' > Program-8-nodejs/README.md
Program - 8 (Node.js)
Create Kubernetes Pods using YAML Descriptors (Node.js & ConfigMap)
Description

This project demonstrates how to create and manage a Kubernetes Pod using declarative YAML descriptors instead of imperative commands. A ConfigMap is used to store a Node.js HTTP server (server.js) and mount it as a volume inside the Pod, which is then accessed externally via kubectl port-forward.
Prerequisites

    Minikube

    kubectl

    Docker

Project Structure
Plaintext

Program-8-nodejs/
├── server.js
├── nodejs-configmap.yaml
├── nodejs-pod.yaml
└── README.md

Step-by-Step Execution Guide
Step 1: Start Minikube & Check Status
Bash

minikube start
minikube status

Step 2: Write the Node.js Application (server.js)
Bash

cat << 'INNER_EOF' > server.js
const http = require("http");
const port = 3000;

const server = http.createServer((req, res) => {
  res.end("Hello from Node.js running inside Kubernetes!");
});

server.listen(port, () => {
  console.log(`Server running at port ${port}`);
});
INNER_EOF

Step 3: Generate nodejs-configmap.yaml via Dry-Run
Bash

kubectl create configmap nodejs-app-config \
  --from-file=server.js \
  --dry-run=client -o yaml \
  > nodejs-configmap.yaml

Step 4: Generate nodejs-pod.yaml with Mounted ConfigMap Volume
Bash

kubectl run nodejs-pod \
  --image=node:18 \
  --port=3000 \
  --labels="app=nodejs" \
  --restart=Never \
  --dry-run=client -o yaml \
  --overrides='{
    "spec": {
      "volumes": [
        { "name": "app-code", "configMap": { "name": "nodejs-app-config" } }
      ],
      "containers": [
        {
          "name": "nodejs-pod",
          "image": "node:18",
          "command": ["node", "/usr/src/app/server.js"],
          "ports": [{ "containerPort": 3000 }],
          "volumeMounts": [
            { "name": "app-code", "mountPath": "/usr/src/app" }
          ]
        }
      ]
    }
  }' > nodejs-pod.yaml

Step 5: Apply Manifests & Verify Pod Status
Bash

kubectl apply -f nodejs-configmap.yaml
kubectl apply -f nodejs-pod.yaml
kubectl get pods

Step 6: Access the Node.js App via Port Forwarding
Bash

kubectl port-forward pod/nodejs-pod 3000:3000

Open http://localhost:3000 in your browser.

    Expected Output: Hello from Node.js running inside Kubernetes!

Step 7: Clean-Up Process
Bash

kubectl delete pods --all
kubectl delete configmap nodejs-app-config
kubectl delete svc --all
kubectl delete deployments --all

Expected Outcomes

    Write and apply declarative YAML manifests (ConfigMap and Pod) to define and create Kubernetes Pods.

    Verify Pod status, container readiness, and volume mounting.

    Access and validate a containerized web application using kubectl port-forward.
    EOF
