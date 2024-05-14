pipeline {
    agent any

    parameters {
        choice(name: 'BRANCH', choices: ['main', 'develop', 'feature', 'master'], description: 'Select the branch to build')
    }
    stages {
        stage('Get Approval by admin') {
            steps {
                input(message: 'Please approvby dk.', submitter: 'admin')
            }
        }
        stage('Checkout Code') {
            steps {
                script {
                    // Get the current branch name
                    def currentBranch = scm.branches[0].name // name of branch
                    currentBranch = currentBranch.substring(currentBranch.lastIndexOf('/') + 1)

                    // Check if the Jenkinsfile branch (develop) matches the build branch
                    if (currentBranch != params.BRANCH) {
                        error "Branch name mismatch! Build branch is '$currentBranch' but Jenkinsfile branch is '$params.BRANCH'"
                        // Stop further execution if branch names don't match
                        return
                    }
                    
                    // Checkout code since branch names match (assuming 'develop')
                    git branch: params.BRANCH, // Assuming your Jenkinsfile is on 'develop' branch
                        credentialsId: 'divyesh-git-cred',
                        url: 'https://github.com/divyesh2508/pacific-web.git'
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
}# Test change
