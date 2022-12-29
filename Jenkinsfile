pipeline{
    agent any
    tools {
  maven 'maven3'
  dockerTool 'docker3'
  terraform 'terraform3'
}
  environment {
     VERSION = "${env.BUILD_ID}"
}
    stages{
        stage('scm'){
            steps{
                git 'https://github.com/sreeramakumar/project1.git'
            }
        }
        stage('maven build'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('terraform ec2 creation for test_server') {
           steps {
               sh '''
                 terraform destroy -auto-approve
                 sleep 45
                 rm -rf .terraform
                 rm -rf .terraform.lock.hcl
                 rm -rf terraform.tfstate
                 rm -rf terraform.tfstate.backup
                 sleep 30
                 terraform init
                 terraform plan
                 terraform apply -auto-approve
                '''
    }
}
stage('ansible install docker on test server for selinium tests'){
            steps{
                sh "chmod 400 ec2.pem"
                sh "sleep 10"
                sh "ansible all -i aws_ec2.yaml -m ping --private-key=ec2.pem -u ec2-user"
                sh " ansible-playbook -i aws_ec2.yaml --private-key=ec2.pem -u ec2-user dockerinstall.yaml "
                sh " ansible-playbook -i aws_ec2.yaml --private-key=ec2.pem -u ec2-user containerplaybook.yaml "
            }
        }
    }
    
}