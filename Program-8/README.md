# Program - 8
## Deploy and Execute Commands in a Python Kubernetes Pod

### Description
This program demonstrates how to start a local Kubernetes cluster using Minikube, create and deploy a standalone Python Pod, view container logs, execute inline and interactive Python commands inside the running container using `kubectl exec`, and clean up cluster resources.

---

### Prerequisites
Make sure you have installed:
- **Minikube:** `https://minikube.sigs.k8s.io/`
- **kubectl:** `https://kubernetes.io/`

---

### Project Structure
```text
Program-8/
├── python-pod.yaml
└── README.md



Step-by-Step Execution Guide (Start to End)

Step 1: Start and Verify Minikube Cluster

Start the local Kubernetes cluster and verify all components are running:
Bash

minikube start
minikube status

(If Minikube fails to start due to a stale network route, reset it using minikube delete && minikube start --driver=docker.)

Step 2: Create Project Directory

Create and navigate into the Program-8 folder:
Bash

mkdir -p Program-8
cd Program-8

Step 3: Create the Pod Manifest (python-pod.yaml)

Method A: Full YAML Manifest
YAML

apiVersion: v1
kind: Pod
metadata:
  name: python-pod
  labels:
    app: python
spec:
  containers:
  - name: python-container
    image: python:3.12-slim
    command: ["python", "-u", "-c"]
    args:
      - |
        import time

        print("Welcome to Kubernetes!")
        print("Python Pod is running successfully.")

        for i in range(1, 6):
            print("Python Execution:", i)
            time.sleep(5)

        print("Python program execution completed.")
        print("Container is waiting...")

        time.sleep(3600)

Method B: Quick Generator Command (Dry-Run)
Bash

kubectl run python-pod \
  --image=python:3.12-slim \
  --restart=Never \
  --dry-run=client -o yaml \
  --command -- python -u -c "import time; print('Welcome to Kubernetes!'); print('Python Pod is running'); time.sleep(3600)" \
  > python-pod.yaml

Step 4: Deploy the Python Pod

Apply the YAML configuration to create the pod in Kubernetes:
Bash

kubectl apply -f python-pod.yaml

Step 5: Check Pod Status and View Logs

Wait until STATUS changes from ContainerCreating to Running (1/1 in READY), then check the logs:
Bash

kubectl get pods
kubectl logs python-pod

Step 6: Execute Python Commands Inside the Running Pod

Run inline commands and open an interactive Python shell inside python-pod:

    Check Python version:
    Bash

    kubectl exec -it python-pod -- python --version

    Run inline print statement:
    Bash

    kubectl exec -it python-pod -- python -c "print('Hello Students!')"

    Run inline arithmetic calculation:
    Bash

    kubectl exec -it python-pod -- python -c "a=10; b=20; print('Sum =', a+b)"

    Open interactive Python shell inside the Pod:
    Bash

    kubectl exec -it python-pod -- python

    (Type exit() and press Enter to exit the interactive Python prompt.)

Step 7: Clean Up Kubernetes Resources

Delete the pod after verification and optionally stop Minikube:
Bash

kubectl delete -f python-pod.yaml
minikube stop
