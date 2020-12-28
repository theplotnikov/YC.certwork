pipeline {
  agent any

  stages {

    stage ('terraform makes plan') {
      steps {
        sh 'terraform init'
        sh 'terraform plan -out create.tfplan'
  }
}
    stage ('approve terraforms applying') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
    }
  }
}
    stage ('terraform apply the plan') {
      steps {
         sh 'terraform apply -auto-approve'
      }
    }

    stage ('execute ansible playbook') {
      steps {
        ansiblePlaybook (
        become: true,
        credentialsId: 'id_rsa',
        installation: 'ansible',
        inventory: '~/cert/playbook.yml',
        playbook: '~/cert/inventory.ini')
      }
    }
  }
}