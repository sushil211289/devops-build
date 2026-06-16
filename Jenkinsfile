pipeline {
    agent any

    environment {
        DOCKERHUB_USER = "sushil2112"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "Checked out branch: ${env.BRANCH_NAME}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        sh "docker build -t ${DOCKERHUB_USER}/dev:latest ."
                    } else if (env.BRANCH_NAME == 'master') {
                        sh "docker build -t ${DOCKERHUB_USER}/prod:latest ."
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    script {
                        if (env.BRANCH_NAME == 'dev') {
                            sh "docker push ${DOCKERHUB_USER}/dev:latest"
                        } else if (env.BRANCH_NAME == 'master') {
                            sh "docker push ${DOCKERHUB_USER}/prod:latest"
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                branch 'dev'
            }
            steps {
                sh '''
                    docker stop devops-app || true
                    docker rm devops-app || true
                    docker run -d \
                        --name devops-app \
                        -p 80:80 \
                        --restart always \
                        sushil2112/dev:latest
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline SUCCESS on branch: ${env.BRANCH_NAME}"
        }
        failure {
            echo "❌ Pipeline FAILED on branch: ${env.BRANCH_NAME}"
        }
    }
}
