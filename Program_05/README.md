---

### Command to Generate this `README.md` directly in Terminal

Run this inside your `Program_05` folder to write the entire file in one step:

```bash
cat << 'EOF' > README.md
# Program 5 – Demonstrate CI Integration by Running Jenkins in a Docker Container

## Description
The problem statement focuses on demonstrating Continuous Integration (CI) by deploying and running Jenkins inside a Docker container. This setup showcases how Docker simplifies Jenkins installation and enables automated build and integration workflows.

## Software Requirements
- Docker Engine
- Docker Compose (https://docs.docker.com/compose/install/)

Verify installation:
docker --version
docker compose version

## Project Structure
Program_05/
├── Dockerfile
├── docker-compose.yml
├── .gitignore
└── README.md

## Step 1: Ensure Docker service is running
docker --version
docker compose version

## Step 2: Create Project Structure → program-5
mkdir program-5
cd program-5

## Step 3: Create a Dockerfile
cat << 'DOCKERFILE' > Dockerfile
FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get install -y docker.io
USER jenkins
DOCKERFILE

## Step 4: Make a file → docker-compose.yml
cat << 'COMPOSE' > docker-compose.yml
version: '3.8'

services:
  jenkins:
    build: .
    container_name: jenkins-ci
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - jenkins_home:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock

volumes:
  jenkins_home:
COMPOSE

## Step 5: Build and Run Jenkins
docker compose up -d --build

## Step 6: Test the running of Jenkins by logging into
http://localhost:8080

Retrieve Admin Password:
docker exec jenkins-ci cat /var/jenkins_home/secrets/initialAdminPassword

## Step 7: List the Docker Images and Delete the Docker Image
docker images
docker image rm program5-jenkins:latest
EOF
