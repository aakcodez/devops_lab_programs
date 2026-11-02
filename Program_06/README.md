# Program - 6
## Deploy an Automated Build Pipeline using Docker Hub & GHCR

### Description
The problem statement aims to deploy an automated build pipeline using Docker Hub for continuous image building and distribution. This ensures that every code push in the repository triggers Docker Hub to build and store updated container images.

---

### Prerequisites

Make sure you have created/installed:
- **A Docker Hub Account:** `https://hub.docker.com/` (Username: `anvitaak01`)
- **A GitHub Repository:** `https://github.com/` (Username: `aakcodez`)
- **Personal Access Tokens:**
  - **Docker Hub PAT:** Create a Docker Hub Personal Access Token (PAT) for CLI login.
  - **GitHub PAT:** Create a GitHub Personal Access Token with package scopes for GHCR authentication.

---

### Project Structure
```text
Program_06/
├── Dockerfile
├── index.js
├── package.json
├── package-lock.json
└── README.md

Step-by-Step Execution Guide
Step 1: Create a GitHub Personal Access Token (PAT)

GitHub:

    Navigate to Settings -> Developer Settings -> Personal Access Tokens -> Fine-grained Tokens (or Classic Tokens).

    Generate a token with the following scopes:

        write:packages

        read:packages

    Copy and store this token securely (used later for GHCR authentication).

Step 2: Create a Dockerfile & Build the Image

    Create application files (index.js & package.json):

JavaScript

// index.js
const express = require("express");
const app = express();
const PORT = 3000;

app.get("/", (req, res) => {
  res.send("Hello from Program 6 Docker Registry Pipeline!");
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});

    Create Dockerfile with comments:

Dockerfile

# Use official Node.js lightweight alpine image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy dependency manifest files
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy application source code
COPY . .

# Expose server port
EXPOSE 3000

# Specify default execution command
CMD ["node", "index.js"]

    Build the local image:

Bash

docker build -t program-6 .

Step 3: Tag the Image for Docker Hub

Tag the local image with your Docker Hub username:
Bash

docker tag program-6 anvitaak01/program-6:latest

Step 4: Push the Image to Docker Hub

Log into Docker Hub using your Docker Hub PAT and push the tagged image:
Bash

# Log in using Docker Hub PAT
echo "<DOCKER_HUB_PAT>" | docker login -u anvitaak01 --password-stdin

# Push image to Docker Hub
docker push anvitaak01/program-6:latest

Step 5: Tag the Image for GitHub Container Registry (GHCR)

Tag the local image for GHCR:
Bash

docker tag program-6 ghcr.io/aakcodez/program-6:latest

Step 6: Push the Image to GHCR

Log in to GHCR using the GitHub PAT created earlier and push the image:
Bash

# Log in to GHCR
echo "<GITHUB_PAT>" | docker login ghcr.io -u aakcodez --password-stdin

# Push the image to GHCR
docker push ghcr.io/aakcodez/program-6:latest

Step 7: Connect the Local Project to GitHub (for Source Code)

Add the remote repository (if not already linked):
Bash

git remote add origin [https://github.com/aakcodez/devops_lab_programs.git](https://github.com/aakcodez/devops_lab_programs.git)

If the remote exists but is incorrect, reset it:
Bash

git remote set-url origin [https://github.com/aakcodez/devops_lab_programs.git](https://github.com/aakcodez/devops_lab_programs.git)

Verify configuration:
Bash

git remote -v

Step 8: Push the Source Code to GitHub
Bash

git add Program_06/
git commit -m "feat: complete Program-6 deployment to Docker Hub and GHCR"
git push -u origin main

Step 9: Verify Uploads on Both Registries

    GitHub:

        Ensure the code repository devops_lab_programs exists and contains Program_06.

        Navigate to Packages under your profile (https://github.com/aakcodez?tab=packages) to check that the image ghcr.io/aakcodez/program-6:latest is visible.

    Docker Hub:

        Check under Repositories (https://hub.docker.com/repositories) that anvitaak01/program-6:latest is listed.

Expected Outcomes

    Establish a link between source code repository and Docker Hub.

    Automatically build and push images upon code commits.

    Verify that updated images are available on Docker Hub for deployment.