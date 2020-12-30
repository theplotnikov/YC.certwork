pipeline {
  agent any

  stages {

    stage ('input the yandex cloud private data') {
      steps {
        timeout(time: 30, unit: 'SECONDS') {
          script {
          def inputcloud_id
          def inputfolder_id
          def inputtoken_id
          def userInput = input (
          id: 'userInput',
          message: 'enter your\'s cloud private data',
          parameters: [
          string (defaultValue: 'YourCloudID', description: 'cloud_id value', name: 'cloud_id'),
          string (defaultValue: 'YourFolderID', description: 'folder_id value', name: 'folder_id'),
          string (defaultValue: 'YourToken', description: 'token_id value', name: 'token_id'),
          ])
          inputcloud_id = userInput.cloud_id?:''
          inputfolder_id = userInput.folder_id?:''
          inputtoken_id = userInput.token_id?:''
          writeFile file: "id_cloud", text: "${inputcloud_id}"
          writeFile file: "id_folder", text: "${inputfolder_id}"
          writeFile file: "id_token", text: "${inputtoken_id}"
      }
    }
  }
}

    stage ('terraform makes the plan to create instances') {
      steps {
        sh 'terraform init'
        sh 'terraform plan -out create.tfplan'
  }
}

    stage ('terraform apply the plan that create instances') {
      steps {
         sh 'terraform apply -auto-approve'
  }
}

    stage ('waiting for instances') {
      steps {
        sleep (
        time: 40,
        unit: "SECONDS")
  }
}

    stage ('execute ansible playbook, that configure instances') {
      steps {
        ansiblePlaybook (
        become: true,
        disableHostKeyChecking: true,
        credentialsId: 'id_key',
        installation: 'ansible',
        inventory: '/var/lib/jenkins/workspace/cert/inventory.yml',
        playbook: '/var/lib/jenkins/workspace/cert/playbook.yml')
      }
    }
  }
}