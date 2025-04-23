pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "akash05378/portfolio-app"  // Name of the Docker image
        DOCKER_HUB_CREDENTIALS = "docker-hub-creds"  // Jenkins Credentials ID for Docker Hub login
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone your GitHub repository
                git 'https://github.com/nightsight30-sky/portfolio-ci-cd'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                // Login to Docker Hub
                withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CREDENTIALS, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                // Push the built image to Docker Hub
                script {
                    docker.push(DOCKER_IMAGE)
                }
            }
        }

        stage('Clean Up') {
            steps {
                // Clean up Docker images to avoid excess storage usage
                sh 'docker rmi $DOCKER_IMAGE'
            }
        }
    }

    post {
        always {
            // Clean workspace after the build is complete
            cleanWs()
        }
    }
}
