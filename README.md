this repository has the Jenkinsfile that:
1. with terraform's create.tf will create two instances in yandexcloud.
2. with ansible's plabook.yml will tune these instances.
   first instance for building war project.
   second instance for deploying project with tomcat8.
   
befor start this pipeline you must 