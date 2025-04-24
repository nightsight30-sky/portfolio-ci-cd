pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "nightsight30/portfolio-app"
        DOCKER_HUB_CREDENTIALS = "docker-hub-creds-v2"
        CONTAINER_NAME = "portfolio-app"
        HOST_PORT = "8081" // Change if 8081 is in use
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/nightsight30-sky/portfolio-ci-cd'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    bat "docker build -t %DOCKER_IMAGE% ."
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS}",
                                                      usernameVariable: 'DOCKER_USERNAME',
                                                      passwordVariable: 'DOCKER_PASSWORD')]) {
                        bat "docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%"
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    bat "docker push %DOCKER_IMAGE%"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove any existing container with the same name (ignore errors)
                    bat "docker stop %CONTAINER_NAME% || exit 0"
                    bat "docker rm %CONTAINER_NAME% || exit 0"
                    // Run the new container with port mapping
                    bat "docker run -d -p %HOST_PORT%:80 --name %CONTAINER_NAME% %DOCKER_IMAGE%"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
