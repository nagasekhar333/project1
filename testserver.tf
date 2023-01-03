provider "aws" {
  region     = "ap-south-1"
}
resource "aws_instance" "production_server" {
  ami           = "ami-074dc0a6f6c764218"
  instance_type = "t2.micro"
  key_name = "jenkins"
   subnet_id = "subnet-0d9fb418acaf32010"
   security_groups = ["sg-0c6da82a9d1e57a89"]
  tags = {
    Env = "production"
    Name = "production_server"
  }
}
