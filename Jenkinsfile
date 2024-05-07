pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                script {
                    // Get the current branch name
                    def currentBranch = 'main'
                    // Get the branch name from the Jenkinsfile path
                     def pipelineBranch = BRANCH_NAME

                    // Compare branch names
                    if (currentBranch == pipelineBranch) {
                        // Checkout code only if branch names match
                        git branch: currentBranch, 
                            credentialsId: 'divyesh-git-cred',
                            url: 'https://github.com/divyesh2508/pacific-web.git'
                    } else {
                        error "Jenkinsfile is not in the same branch as the Jenkins pipeline."
                    }
                }
            }
        }
       stage('Get Approval') {
            steps {
                input(message: 'Please approve this build.', submitter: 'admin')
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
}

