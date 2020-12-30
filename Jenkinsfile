pipeline {
  agent any

  stages {

    stage ('input the yandex cloud private data') {
      steps {
        script {
        def inputcloud_id
        def inputfolder_id
        def inputtoken_id
        def inputkey_id.pub
        def userInput = input (
        id: 'userInput',
        message: 'enter your\'s cloud private data',
        parameters: [
        string (defaultValue: 'None', description: 'cloud_id value', name: 'cloud_id'),
        string (defaultValue: 'None', description: 'folder_id value', name: 'folder_id'),
        string (defaultValue: 'None', description: 'token_id value', name: 'token_id'),
        string (defaultValue: 'None', description: 'key_id.pub value', name: 'key_id.pub'),
        ])
        inputcloud_id = userInput.cloud_id?:''
        inputfolder_id = userInput.folder_id?:''
        inputtoken_id = userInput.token_id?:''
        inputkey_id.pub = userInput.key_id.pub?:''
        writeFile file: "id_cloud", text: "${inputcloud_id}"
        writeFile file: "id_folder", text: "${inputfolder_id}"
        writeFile file: "id_token", text: "${inputtoken_id}"
        writeFile file: "id_key.pub", text: "${inputkey_id.pub}"
    }
  }
}

    stage ('terraform makes the plan to create instances') {
      steps {
        sh 'terraform init'
        sh 'terraform plan -out create.tfplan'
  }
}

    stage ('terraform apply the plan and create instances') {
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