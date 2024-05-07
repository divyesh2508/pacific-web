pipeline {
    agent any

    parameters {
        choice(name: 'BRANCH', choices: ['main', 'develop', 'feature'], description: 'Select the branch to build')
        // choice(name: 'DEPLOY_SCRIPT', choices: ['deploy_script_1.sh', 'deploy_script_2.sh', 'deploy_script_3.sh'], description: 'Select the deployment script')
    }
    stages {
        stage('Checkout Code') {
            steps {
                script {
                    // Get the current branch name
                    def currentBranch = scm.branches[0].name
                    currentBranch = currentBranch.substring(currentBranch.lastIndexOf('/') + 1)

                    // Check if the Jenkinsfile branch (develop) matches the build branch
                    if (currentBranch != parameters.BRANCH) {
                        error "Branch name mismatch! Build branch is '$currentBranch' but Jenkinsfile branch is 'develop'."
                        // Stop further execution if branch names don't match
                        return
                    }
                    
                    // Checkout code since branch names match (assuming 'develop')
                    git branch: parameters.BRANCH, // Assuming your Jenkinsfile is on 'develop' branch
                        credentialsId: 'divyesh-git-cred',
                        url: 'https://github.com/divyesh2508/pacific-web.git'
                }
            }
        }
        // Add your other pipeline stages here (e.g., Get Approval, Build Docker Image)
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