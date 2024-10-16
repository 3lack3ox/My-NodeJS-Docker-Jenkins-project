pipeline {
  agent any

  stages {
    stage('Clone Repository') {
      steps {
        git branch: 'main', url: 'https://github.com/3lack3ox/My-NodeJS-Docker-Jenkins-project.git'
      }
    }
    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build('my-node-app')
        }
      }
    }
    stage('Run Tests') {
      steps {
        script {
          // Run tests within the Docker container using the built image
          dockerImage.run('-t --rm my-node-app npm test')
        }
      }
    }
  }
}
