pipeline {
    agent any
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

                    // Check if the Jenkinsfile branch (develop) matches the build branch
                    if (currentBranch != 'develop') {
                        error "Branch name mismatch! Build branch is '$currentBranch' but Jenkinsfile branch is 'develop'."
                        // Stop further execution if branch names don't match
                        return
                    }
                    
                    // Checkout code since branch names match (assuming 'develop')
                    git branch: 'develop', // Assuming your Jenkinsfile is on 'develop' branch
                        credentialsId: 'git-cred',
                        url: 'https://github.com/Aesha001/Pacific_Project'
                }
            }
        }
        // Add your other pipeline stages here (e.g., Get Approval, Build Docker Image)
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("ptt-project-img")
                }
            }
        }
    }
}