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
    }
}

