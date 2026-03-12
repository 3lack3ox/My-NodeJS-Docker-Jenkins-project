# NodeApp-CICD

## Description
A Node.js application containerized with Docker, built and tested through a CI/CD pipeline using GitHub Actions, and deployed automatically to an EC2 instance.

## Table of Contents
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [CI/CD Workflow](#cicd-workflow)
- [Architecture](#architecture)
- [Contributing](#contributing)
- [License](#license)

---

## Technologies Used
- Node.js
- Docker
- GitHub Actions
- Jest (for testing)

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/3lack3ox/NodeApp-CICD.git
   ```

2. Navigate to the project directory:
   ```bash
   cd NodeApp-CICD
   ```

3. Install dependencies:
   ```bash
   npm install
   ```

---

## Usage

1. To run the application locally:
   ```bash
   node server.js
   ```

2. To build and run the Docker container:
   ```bash
   docker build -t my-node-app .
   docker run -p 3000:3000 my-node-app
   ```

3. Access the app in your browser:
   ```
   http://localhost:3000
   ```

---

## CI/CD Workflow

The GitHub Actions pipeline triggers on every push or pull request to `main` and performs the following steps:

1. **Checkout** – Pulls the latest code
2. **Set up Node.js** – Configures Node.js v18
3. **Login to Docker Hub** – Authenticates using GitHub Secrets
4. **Tag Image** – Tags the Docker image with the short Git SHA (7 characters)
5. **Build Image** – Builds the Docker image
6. **Run Tests** – Executes Jest tests inside the Docker container
7. **Push Image** – Pushes the SHA-tagged image to Docker Hub
8. **Deploy to EC2** – SSHs into the EC2 instance and runs the latest container
9. **Health Check** – Verifies the service is live on port 3000

### GitHub Secrets Required

| Secret | Description |
|---|---|
| `DOCKER_USERNAME` | Docker Hub username |
| `DOCKER_PASSWORD` | Docker Hub password or access token |
| `EC2_HOST` | Public IP address of the EC2 instance |
| `EC2_SSH_KEY` | Private SSH key for EC2 access |

---

## Architecture

```
   +--------------------+
   |   GitHub Actions   |
   |  (CI/CD Pipeline)  |
   +---------+----------+
             |
             v
   +--------------------+
   |     Docker Hub     |
   |  (Image Registry)  |
   +---------+----------+
             |
             v
   +--------------------+
   |        EC2         |
   |  Docker Container  |
   |   Node.js App      |
   +--------------------+
             |
             v
        Users/Clients
```

---

## Contributing

If you'd like to contribute, please fork the repository and submit a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
