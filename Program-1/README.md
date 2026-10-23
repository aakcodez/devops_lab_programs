# Program 1: Build a Docker Container from a Custom Dockerfile

## Course
DevOps Automation (MCA2621A)

## Objective
Build a Docker container from a custom Dockerfile that packages a Flask
application and its dependencies to run consistently across environments.

## Files
- `Dockerfile` — Build instructions for the container image
- `app.py` — Flask web app that returns "Hello, Docker!"
- `requirements.txt` — Python dependencies (flask)

## Steps
1. `docker build -t program-1 .`
2. `docker run -d -p 5000:5000 --name flask-container program-1`
3. Open `http://localhost:5000` → should show "Hello, Docker!"
4. `docker container stop flask-container`
5. `docker container rm flask-container`
6. `docker image rm program-1`

## Key Concepts
- FROM → base image
- WORKDIR → working directory inside container
- COPY → copy files into image
- RUN → execute command at build time
- ENV → set environment variables
- EXPOSE → document which port the app listens on
- CMD → default command when container starts   
