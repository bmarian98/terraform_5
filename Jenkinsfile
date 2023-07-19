def gitRepoUrl = 'https://github.com/bmarian98/terraform_5.git'

pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:latest'
        }
    }
    environment {
        AWS_ACCESS_KEY_ID = credentials('mb-aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('mb-aws-secret-access-key')
        AWS_REGION = 'eu-central-1'
        TF_VAR_db_user = 'dev'
        TF_VAR_db_pass = credentials('mb-db-pass')
        TF_VAR_db_url = 'jdbc:mysql://bm-mysql.cix71ohkd2tr.eu-central-1.rds.amazonaws.com:3306/test'
        TF_VAR_s3_app = 's3://bm-s3-bucket/web-app/'
    }

    stages {
        // stage('Data storage') {
        //     steps {
        //         script{
        //             git branch: 'main', url: gitRepoUrl
        //         }

        //         dir('live/dev/data-storage') {
        //             sh 'terraform init'
        //         }

        //         dir('live/dev/data-storage') {
        //             sh 'terraform plan'
        //         }

        //         dir('live/dev/data-storage') {
        //             echo "Terraform action: ${action}"
        //             sh "terraform ${action} -auto-approve"
        //         }
        //     }
        // }
        stage('Network') {
            steps {
                script {
                    git branch: 'main', url: gitRepoUrl
                }

                dir('live/dev/network') {
                    sh 'terraform init'
                }

                dir('live/dev/network') {
                    sh 'terraform plan'
                }

                dir('live/dev/network') {
                    echo "Terraform action: ${action}"
                    sh "terraform ${action} -auto-approve"
                }
            }
        }
        stage('Services') {
            steps {
                script {
                    git branch: 'main', url: gitRepoUrl
                }

                dir('live/dev/services') {
                    sh 'terraform init'
                }

                dir('live/dev/services') {
                    sh 'terraform plan'
                }

                dir('live/dev/services') {
                    echo "Terraform action: ${action}"
                    sh "terraform ${action} -auto-approve"
                }
            }
        }
    }
}