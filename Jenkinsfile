pipeline {

agent {
    kubernetes {
        label 'k8s-agent'
        defaultContainer 'maven'
    }
}

environment {
    IMAGE_NAME = "jeevan11cs/java-app"
    IMAGE_TAG = "v1"
}

stages {
    stage('checkout code') {
        steps {
            git branch: 'master'
            url: 'https://github.com/csjeevan11/project-01.git'
        }
    }

    stage('Build War') {
        steps {
            container('maven') {
                sh 'mvn clean package'
            }
        }
    }

    stage('Build Docker Image') {
        steps {
            container('docker') {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }
    }

    stage('Push Docker Image') {
        steps {
            container('docker') {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push ${IMAGE_NAME}:${IMAGE_TAG}
                }
            }
        }
    }

    stage('Deploy to k8s') {
        steps {
            sh'''
            kubectl apply -f k8s/deployment.yaml
            kubectl apply -f k8s/service.yaml
            '''
        }
    }
}
}