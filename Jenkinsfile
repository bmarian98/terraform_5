def gitRepoUrl = 'https://github.com/bmarian98/terraform_5/tree/main'
pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:latest'            
        }
    }
    environment {
        AWS_ACCESS_KEY_ID = credentials('mb-aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('mb-aws-secret-access-key')
        AWS_REGION="eu-central-1"
        TF_VAR_db_user = "dev"
        TF_VAR_db_pass= credentials('mb-db-pass')
        TF_VAR_db_url="jdbc:mysql://bm-mysql.cix71ohkd2tr.eu-central-1.rds.amazonaws.com:3306/test"
        TF_VAR_s3_app="s3://bm-s3-bucket/web-app/"
    }
    
    stages {
        stage('Data storage') {
            steps {
                git branch: 'main', url: gitRepoUrl
            }
            stage('Terraform Init - Data storage') {
                steps {
                    dir('live/dev/data-storage') {
                        sh 'terraform init'
                    }
                }
            }
            stage('Terraform Plan - Data storage') {
                steps {
                    dir('live/dev/data-storage') {
                        sh 'terraform plan'
                    }
                }
            }
            stage('Terraform Action - Data storage') {
                steps {
                    dir('live/dev/data-storage') {
                        echo "Terraform action: ${action}"
                        sh "terraform ${action} -auto-approve"
                    }
                }
            }
        }
        stage('Network') {
            steps {
                git branch: 'main', url: gitRepoUrl
            }
            stage('Terraform Init - Network') {
                steps {
                    dir('live/dev/network') {
                        sh 'terraform init'
                    }
                }
            }
            stage('Terraform Plan - Network') {
                steps {
                    dir('live/dev/network') {
                        sh 'terraform plan'
                    }
                }
            }
            stage('Terraform Action - Network') {
                steps {
                    dir('live/dev/network') {
                        echo "Terraform action: ${action}"
                        sh "terraform ${action} -auto-approve"
                    }
                }
            }
        }
        stage('Services') {
            steps {
                git branch: 'main', url: gitRepoUrl
            }
            stage('Terraform Init - Services') {
                steps {
                    dir('live/dev/services') {
                        sh 'terraform init'
                    }
                }
            }
            stage('Terraform Plan - Services') {
                steps {
                    dir('live/dev/services') {
                        sh 'terraform plan'
                    }
                }
            }
            stage('Terraform Action - Services') {
                steps {
                    dir('live/dev/services') {
                        echo "Terraform action: ${action}"
                        sh "terraform ${action} -auto-approve"
                    }
                }
            }
        }
    }
}
