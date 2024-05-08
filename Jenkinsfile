pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY_CREDENTIALS = 'your-docker-credentials'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    docker.build('your-dotnet-module')
                }
            }
        }

        stage('Test') {
            steps {
                // Add your test steps here
                echo 'Running tests...'
            }
        }

        stage('Publish Docker Image') {
            steps {
                script {
                    // Push the Docker image to your Docker registry
                    docker.withRegistry('https://your-docker-registry-url', DOCKER_REGISTRY_CREDENTIALS) {
                        docker.image('your-dotnet-module').push('latest')
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy your Docker image (replace with your deployment steps)
                    sh 'docker run -d -p 80:80 --name your-dotnet-app your-dotnet-module:latest'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded! Application deployed successfully.'
        }
        failure {
            echo 'Pipeline failed! Application deployment failed.'
        }
    }
}

