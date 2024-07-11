pipeline {
    agent any

    environment {
        ACR_NAME = 'myacr'
        ACR_LOGIN_SERVER = ''
        ACR_PASSWORD = ''
        AKS_RESOURCE_GROUP = 'Muhammad-Candidate'
        AKS_CLUSTER_NAME = 'myakscluster'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                git 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Get ACR login server
                    ACR_LOGIN_SERVER = sh(script: "az acr show --name ${ACR_NAME} --query loginServer --output tsv", returnStdout: true).trim()
                    // Get ACR password
                    ACR_PASSWORD = sh(script: "az acr credential show --name ${ACR_NAME} --query 'passwords[0].value' --output tsv", returnStdout: true).trim()

                    // Build and push Docker image
                    sh """
                    docker build -t ${ACR_LOGIN_SERVER}/myapp:latest .
                    echo ${ACR_PASSWORD} | docker login ${ACR_LOGIN_SERVER} --username ${ACR_NAME} --password-stdin
                    docker push ${ACR_LOGIN_SERVER}/myapp:latest
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
