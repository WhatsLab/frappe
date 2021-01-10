pipeline {
    agent { node { label 'jenkins-slave' } }
    stages {
        stage('Build image') {
            steps {
                echo 'Starting to build docker image'
                withDockerRegistry([ credentialsId: "gcr:nana-registry", url: "https://gcr.io" ]) {
                    script{
                        tag = sh (script: 'cat version', returnStdout: true)
                        app = docker.build("gcr.io/nana-direct-cloud/frappe-framework")
                        app.push("${tag}")
                        app.push('latest')
                    }
                }
            }
        }
        stage('Remove Docker Image') {
            steps{
                script {
                    tag = sh (script: 'cat version', returnStdout: true)
                    sh "/usr/bin/docker rmi ${registry}:latest"
                    sh "/usr/bin/docker rmi ${registry}:${tag}"
                }
            }
        }
    }
}

