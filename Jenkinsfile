pipeline {
    agent any

    stages {
        stage('Download Jenkinsfile') {
            steps {
                script {
                    def awsCredentials = amazonWebServices(credentialsId: 'aws-creds', regionName: 'ap-south-1')
                    def s3Object = awsS3GetObject(
                        credentials: awsCredentials,
                        regionName: 'ap-south-1',
                        bucket: 'myjenkinsfilebucket',
                        path: 'Jenkinsfile'
                    )
                    def jenkinsfileContent = s3Object.getObjectContent().toString('UTF-8')
                    writeFile file: 'Jenkinsfile', text: jenkinsfileContent
                }
            }
        }

        stage('Build') {
            steps {
                // Your build steps here
                // For example:
                sh 'chmod +x Jenkinsfile'
                sh './Jenkinsfile'
            }
        }
    }
}
