resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.joindevops.id
  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-064b842683170e6c5"]  #
  subnet_id              = "subnet-046eb89e75484576a"
  user_data = file("jenkins.sh")

  root_block_device {
    volume_size = 50  # Set root volume size to 50GB
    volume_type = "gp3"  # Use gp3 for better performance (optional)
    delete_on_termination = true  # Automatically delete the volume when the instance is terminated
  }
  tags = merge(
    var.common_tags,
    {
        Name = "Jenkins"
    }
  )
}

resource "aws_instance" "jenkins-agent" {
  ami                    = data.aws_ami.joindevops.id
  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-064b842683170e6c5"]  #replace your SG
  subnet_id              = "subnet-046eb89e75484576a" #replace you subnet
  user_data = file("jenkins-agent.sh")
  # Define the root volume size and type
  root_block_device {
    volume_size = 50  # Set root volume size to 50GB
    volume_type = "gp3"  # Use gp3 for better performance (optional)
    delete_on_termination = true  # Automatically delete the volume when the instance is terminated
  }
  tags = merge(
    var.common_tags,
    {
        Name = "Jenkins-agent"
    }
  )
}

resource "aws_route53_record" "jenkins" {
  zone_id = var.zone_id
  name    = "jenkins"
  type    = "A"
  ttl     = 1
  records = [aws_instance.jenkins.public_ip]
}

resource "aws_route53_record" "jenkins_agent" {
  zone_id = var.zone_id
  name    = "jenkins-agent"
  type    = "A"
  ttl     = 1
  records = [aws_instance.jenkins-agent.private_ip]
}