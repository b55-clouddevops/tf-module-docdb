# Creates Security Group
resource "aws_security_group" "allows_docdb" {
  name        = "Roboshop allows docdb internal traffic only"
  description = "Allows Only private traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID


  ingress {
    description      = "docdb from private Network"
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allows_private_traffic"
  }
}