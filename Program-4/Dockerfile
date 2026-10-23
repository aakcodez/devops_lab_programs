# Use official Node.js runtime as parent image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /usr/src/app

# Copy dependency manifests first to leverage Docker layer caching
COPY package*.json ./

# Install application dependencies
RUN npm install --production

# Copy application source code
COPY . .

# Expose container port
EXPOSE 3000

# Specify default start command
CMD ["npm", "start"]

