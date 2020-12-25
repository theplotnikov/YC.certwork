pipeline {
  agent any

  stages {

    stage ('terraform makes plan') {
      steps {
        sh 'terraform init'
        sh 'terraform plan -out create.tfplan'
  }
}
    stage ('approve terraforms apllying') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
    }
  }
}
    stage ('terraform aplly the plan') {
      steps {
        sh terraform apply
      }
    }
  }
}