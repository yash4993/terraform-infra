provider "aws" {
  region     = "us-east-2"
  access_key = "somexyza"
  secret_key = "somexyz"
}

resource "aws_instance" "node" {
  ami           = "ami-000e7ce4dd68e7a11"
  instance_type = "t2.micro"
  key_name      = "ybotcha2"
  vpc_security_group_ids = ["sg-02ebf5c23907cd240"]

  tags = {
    Name = "Instance-new"
  }
}

resource "null_resource" "connection-to-ec2" {

    connection {
        type     = "ssh"
        user     = "centos"
        host     = "${aws_instance.node.public_ip}"
        private_key = "${file("/opt/ybotcha2.pem")}"
    }
    
    provisioner "file" {
        source      = "/opt/*.war"
        destination = "/home/centos/"
    }


    provisioner "remote-exec" {
    inline = [
      "sudo yum install git ansible -y",
      "sudo yum install tomcat -y",
      "cp /home/centos/*.war /var/lib/tomcat/webapps"
      "systemctl start tomcat"
      "systemctl enble tomcat"
     
    ]
  }
}
