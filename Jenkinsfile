pipeline {
    agent any

    parameters {
        choice(name: 'BRANCH', choices: ['main', 'develop', 'feature'], description: 'Select the branch to build')
    }
    stages {
        stage('Download Jenkinsfile from S3') {
            steps {
                script {
                    // Download Jenkinsfile from S3 bucket using AWS credentials
                    withAWS(region: 'ap-south-1', credentials: 'aws-creds') {
                         sh 'aws s3 cp s3://myjenkinsfilebucket/Jenkinsfile Jenkinsfile'
                    }
                }
            }
        }
        
        // Rest of your pipeline stages assuming downloaded Jenkinsfile defines further steps
    stage('Execute Downloaded Jenkinsfile') {
        steps {
                script {
                    // Assuming Jenkinsfile content is a valid Groovy script
                    sh './Jenkinsfile'        
                
                    }
                }
            }
    }
}