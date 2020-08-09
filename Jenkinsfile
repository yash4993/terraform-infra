node() {
    stage ('creating aws bucket') {
        git credentialsId: 'Github-User1', url 'https://github.com/yash4993/terraform-infra.git'
          sh '''
          cd s3
          terraform init
          terraform apply -auto-approve
          cd ../..
          '''
    }
    stage('Clone-Git-Repo') {
        git credentialsId: 'Github-User1', url: 'https://github.com/yash4993/jenkins.git'
    }
    stage('Upload-Artifacts into S3') {
                 withCredentials([usernamePassword(credentialsId: 'AWS-Keys', passwordVariable: 'AWSSECRET', usernameVariable: 'AWSKEY')]) {
                        sh '''
                            export AWS_ACCESS_KEY_ID=$AWSKEY
                            export AWS_SECRET_ACCESS_KEY=$AWSSECRET
                            export AWS_DEFAULT_REGION="us-east-2"   
                            cd jenkins
                            mvn clean package
                            ls -ltr target
                            aws s3 cp /var/lib/jenkins/workspace/jenkins/target/*.war s3:///yash4993bucket/Folder1/
                            cd ../
                '''
            
        }
    }
    stage('deply war file to aws ec2'){
        sh '''
        cp /var/lib/jenkins/workspace/jenkins/target/*.war /opt/
        cd ec2
        terraform init
        terraform apply -auto-approve
       
      '''
  }

}
