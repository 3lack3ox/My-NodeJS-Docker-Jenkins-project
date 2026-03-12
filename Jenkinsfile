pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "3lack3ox/my-node-app:latest"
        DOCKER_USERNAME = credentials('dockerhub-username')
        DOCKER_PASSWORD = credentials('dockerhub-password')
        EC2_HOST = credentials('ec2-host')
        EC2_USER = 'ubuntu'
        EC2_SSH_KEY = credentials('ec2-ssh-key') // private key stored as Jenkins credential
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/3lack3ox/My-NodeJS-Docker-Jenkins-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    dockerImage.inside {
                        sh 'npm test'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    // SSH into EC2 and deploy
                    sh """
                    ssh -i ${EC2_SSH_KEY} ${EC2_USER}@${EC2_HOST} '
                      docker pull ${DOCKER_IMAGE} &&
                      docker stop my-node-app || true &&
                      docker rm my-node-app || true &&
                      docker run -d --name my-node-app -p 3000:3000 ${DOCKER_IMAGE}'
                    """
                }
            }
        }
    }
}