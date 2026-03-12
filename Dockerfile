# Node.js Image
FROM node:latest

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install 

# Copy the application code
COPY . .

# Create a non-root user
RUN useradd -m appuser
USER appuser

# Expose port 3000 for the app
EXPOSE 3000

# Run the application
CMD ["node", "server.js"] 

