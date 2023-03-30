pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "my-registry.com"
        KUBECONFIG = credentials('kubeconfig')
    }

    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    def dockerImage = docker.build("my-registry.com/my-nginx:1.19")
                    docker.withRegistry("${DOCKER_REGISTRY}", "docker-registry-credentials") {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig(credentialsId: 'kubeconfig') {
                        sh "kubectl apply -f nginx-statefulset.yaml"
                    }
                }
            }
        }
    }
}
