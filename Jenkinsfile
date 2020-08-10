node() {
    stage ('creating aws bucket') {
        git credentialsId: 'Github-User1', url: 'https://github.com/yash4993/terraform-infra.git'
          sh '''
          cd s3
         /usr/local/bin/terraform init
          /usr/local/bin/terraform apply -auto-approve
          cd ../
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
                            mvn clean package
                            ls -ltr target
                            /usr/local/bin/aws s3 cp /var/lib/jenkins/workspace/jenkins/target/*.war s3:///yash4993bucket/Folder1/
                       
                '''
            
        }
    }
    stage('deply war file to aws ec2'){
        sh '''
        cp /var/lib/jenkins/workspace/jenkins/target/*.war /opt/
        cd ec2
        /usr/local/bin/terraform init
        /usr/local/bin/terraform apply -auto-approve
       
      '''
  }

}
