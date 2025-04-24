pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "nightsight30/portfolio-app" // Use your Docker Hub username!
        DOCKER_HUB_CREDENTIALS = "docker-hub-creds-v2"
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

        // ADD THIS STAGE TO RUN THE CONTAINER WITH PORT MAPPING
        stage('Run Docker Container') {
            steps {
                script {
                    bat "docker stop portfolio-app || exit 0"
                    bat "docker rm portfolio-app || exit 0"
                    bat "docker run -d -p 8081:80 --name portfolio-app %DOCKER_IMAGE%"
                }
            }
        }


        stage('Clean Up') {
            steps {
                script {
                    bat "docker rmi %DOCKER_IMAGE%"
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
