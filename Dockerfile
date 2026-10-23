# Stage 1: Build dependencies

# Use Node.js 20 with Alpine Linux as the base image
FROM node:20-alpine AS build

# Set the working directory
WORKDIR /app

# Copy dependencies
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the source folder containing index.js
COPY src/ ./src/


# Stage 2: Runtime image

# Use alpine for production
FROM node:20-alpine AS prod

# Set the working directory
WORKDIR /app

# Copy the application files and installed dependencies
COPY --from=build /app /app

# Expose port 3000
EXPOSE 3000

# Start the Node.js
CMD ["node", "src/index.js"]