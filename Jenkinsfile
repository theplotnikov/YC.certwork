pipeline {
  agent any

  stages {

    stage ('input the yandex cloud id') {
      steps {
        script {
        def inputcloud_id
        def userInput = input (
        id: 'userInput',
        message: 'enter your\'s yandex cloud id',
        parameters: [
        string (defaultValue: 'YourCloudID', description: 'cloud_id value', name: 'cloud_id'),
        ])
        inputcloud_id = userInput.cloud_id?:''
        writeFile file: "id_cloud", text: "${inputcloud_id}"
    }
  }
}

    stage ('input the yandex folder id') {
      steps {
        script {
        def inputfolder_id
        def userInput = input (
        id: 'userInput',
        message: 'enter your\'s yandex folder id',
        parameters: [
        string (defaultValue: 'YourFolderID', description: 'folder_id value', name: 'folder_id'),
        ])
        inputfolder_id = userInput.folder_id?:''
        writeFile file: "id_folder", text: "${inputfolder_id}"
    }
  }
}

    stage ('input the yandex token') {
      steps {
        script {
        def inputtoken_id
        def userInput = input (
        id: 'userInput',
        message: 'enter your\'s yandex token',
        parameters: [
        string (defaultValue: 'YourToken', description: 'token_id value', name: 'token_id'),
        ])
        inputtoken_id = userInput.token_id?:''
        writeFile file: "id_token", text: "${inputtoken_id}"
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