FROM jenkins/jenkins:lts

# Switch to root user to install tools
USER root

# Install Docker inside Jenkins container
RUN apt-get update && apt-get install -y docker.io

# Switch back to Jenkins user
USER jenkins
