pipeline {
    agent any

    environment {
        ACR_NAME = '2bcloud.azurecr.io'
        ACR_LOGIN_SERVER = ''
        ACR_PASSWORD = ''
        AKS_RESOURCE_GROUP = 'Muhammad-Candidate'
        AKS_CLUSTER_NAME = 'myakscluster'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                git 'https://github.com/maatif-us/2bcloud.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {

                    ACR_LOGIN_SERVER = sh(script: "az acr show --name ${ACR_NAME} --query loginServer --output tsv", returnStdout: true).trim()
                    ACR_PASSWORD = sh(script: "az acr credential show --name ${ACR_NAME} --query 'passwords[0].value' --output tsv", returnStdout: true).trim()

                    // Build and push Docker image
                    sh """
                    docker build -t ${ACR_LOGIN_SERVER}/test-image:latest .
                    echo ${ACR_PASSWORD} | docker login ${ACR_LOGIN_SERVER} --username ${ACR_NAME} --password-stdin
                    docker push ${ACR_LOGIN_SERVER}/test-image:latest
                    """
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                script {
                    // Get AKS credentials
                    sh "az aks get-credentials --resource-group ${AKS_RESOURCE_GROUP} --name ${AKS_CLUSTER_NAME} --overwrite-existing"

                    // Deploy to AKS
                    sh """
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                    """
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    // Verify the deployment
                    sh """
                    kubectl rollout status deployment/myapp-deployment
                    """
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace
            cleanWs()
        }
    }
}
