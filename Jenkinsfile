pipeline {
    agent {
        docker {

            image 'marian14/alpine-terraform:1.1'            

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

        stage('Clone repository') {
            steps {
                script{
                    checkout scm
                }
            }
        }
        // stage('Data storage') {
        //     steps {
        //         dir('live/dev/data-storage') {
        //             docker.image('hashicorp/terraform:latest').inside{
        //                 sh 'terraform init'
        //             }
        //         }

        //         dir('live/dev/data-storage') {
        //             docker.image('hashicorp/terraform:latest').inside{
        //                 sh 'terraform plan'
        //             }
        //         }

        //         dir('live/dev/data-storage') {
        //             docker.image('hashicorp/terraform:latest').inside{
        //                 echo "Terraform action: ${action}"
        //                 sh "terraform ${action} -auto-approve"
        //             }
        //         }
        //     }
        // }
        stage('Network') {
            steps {
                dir('live/dev/network') {
                    script {
                        //docker.image('hashicorp/terraform:latest').inside{
                            sh 'terraform init'
                        //}
                    }
                }

                dir('live/dev/network') {
                    script {
                        //docker.image('hashicorp/terraform:latest').inside{
                            sh 'terraform plan'
                        //}
                    }
                }

                dir('live/dev/network') {
                    script {
                        //docker.image('hashicorp/terraform:latest').inside{
                            echo "Terraform action: ${action}"
                            sh "terraform ${action} -auto-approve"
                        //}
                    }
                }
            }
        }
        stage('Services') {
            steps {
                dir('live/dev/services') {
                    script {
                        //docker.image('hashicorp/terraform:latest').inside{
                            sh 'terraform init'
                        //}
                    }
                }

                dir('live/dev/services') {
                    script {
                        //docker.image('hashicorp/terraform:latest').inside{
                            sh 'terraform plan'
                        //}
                    }
                }

                dir('live/dev/services') {
                    script {
                        //docker.image('hashicorp/terraform:latest').inside{
                            echo "Terraform action: ${action}"
                            sh "terraform ${action} -auto-approve"
                        //}
                    }
                }
            }
        }
    }
}