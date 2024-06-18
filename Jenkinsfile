pipeline {
    agent any

    parameters {
        choice(name: 'BRANCH', choices: ['main', 'develop', 'feature'], description: 'Select the branch to build')
    }

    environment {
        AWS_REGION = 'ap-south-1'  // Update with your AWS region
        AWS_CREDENTIALS_ID = 'aws-creds'  // Update with your AWS credentials ID
    }

    stages {
        stage('Get Approval') {
            steps {
                input(message: 'Please approve this build.', submitter: 'admin')
            }
        }
        
        stage('Checkout Code') {
            steps {
                script {
                    // Get the current branch name
                    def currentBranch = scm.branches[0].name
                    currentBranch = currentBranch.substring(currentBranch.lastIndexOf('/') + 1)

                    // Check if the Jenkinsfile branch matches the build branch
                    if (currentBranch != params.BRANCH) {
                        error "Branch name mismatch! Build branch is '$currentBranch' but Jenkinsfile branch is '$params.BRANCH'"
                        // Stop further execution if branch names don't match
                        return
                    }
                    
                    // Checkout code since branch names match
                    git branch: params.BRANCH,
                        credentialsId: 'divyesh-git-cred',
                        url: 'https://github.com/divyesh2508/pacific-web.git'
                }
            }
        }

        stage('Download .env from S3') {
            steps {
                withAWS(region: "${AWS_REGION}", credentials: "${AWS_CREDENTIALS_ID}") {
                    s3Download(file: '.env', bucket: 'mytestbuckedk', path: '.env')
                }
            }
        }

        stage('Load .env') {
            steps {
                script {
                    // Read .env file content
                    def envFile = readFile('.env').trim()
                    
                    // Split by lines and set environment variables
                    envFile.readLines().each { line ->
                        def keyValue = line.split('=')
                        if (keyValue.size() == 2) {
                            env."${keyValue[0].trim()}" = keyValue[1].trim()
                        }
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("ptt-project-img")
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
