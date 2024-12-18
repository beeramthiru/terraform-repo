
resource "aws_instance" "MyFirstInstnace" {
  count         = 3
  ami           = "ami-0b0ea68c435eb488d"
  instance_type = "t2.micro"

  tags = {
    Name = "demoinstnce-${count.index}"
  }
}