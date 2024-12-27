#Security Group for levelupvpc
resource "aws_security_group" "custom_security_group" {
  vpc_id      = aws_vpc.custom_vpc.id
  name        = "custom_security_group"
  description = "security group that allows ssh connection"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "custom_security_group"
  }
}

