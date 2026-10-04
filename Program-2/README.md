# Program 2: Multi-Stage Dockerfile for Container Orchestration

## Course
DevOps Automation (MCA2621A)

## Objective
Develop a multi-stage Dockerfile to optimize image size, improve security,
and streamline the build and deployment process.

## Files
- `Dockerfile` — Multi-stage build (builder + production)
- `package.json` — Node.js project config + build script
- `package-lock.json` — Locked dependency versions
- `src/index.js` — Express app returning "Hello from multi-stage Docker!"

## Steps
1. `npm install`
2. `docker build -t program-2 .`
3. `docker run -d -p 3000:3000 --name node-container program-2`
4. Open `http://localhost:3000` → "Hello from multi-stage Docker!"
5. `docker container stop node-container`
6. `docker container rm node-container`

## Key Concepts
- Multi-stage build: builder stage (compile/install) → production stage (run only)
- `AS builder` names the first stage
- `COPY --from=builder` pulls files from the previous stage
- Final image only contains production stage → smaller + more secure
- `node:20-alpine` = lightweight Node.js on Alpine Linux   
