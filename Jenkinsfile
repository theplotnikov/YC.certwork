pipeline {
  agent any

  stages {

    stage ('terraform makes plan') {
      steps {
        sh 'terraform init'
        sh 'terraform plan -out create.tfplan'
  }
}

    stage ('terraform apply the plan') {
      steps {
         sh 'terraform apply -auto-approve'
      }
    }

    stage ('waiting for instances') {
      steps {
        sleep (
        time: 20,
        unit: "SECONDS")

    stage ('execute ansible playbook') {
      steps {
        ansiblePlaybook (
        become: true,
        disableHostKeyChecking: true,
        credentialsId: 'key1',
        installation: 'ansible',
        inventory: '/var/lib/jenkins/workspace/cert/inventory.yml',
        playbook: '/var/lib/jenkins/workspace/cert/playbook.yml')
      }
    }
  }
}