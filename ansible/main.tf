provider "aws" {
  region = var.aws_region
}

# Key pair para SSH
resource "aws_key_pair" "lab_key" {
  key_name   = "sprint5-lab-key"
  public_key = file("~/.ssh/sprint5-lab.pub")
}

# Security Group para permitir SSH
resource "aws_security_group" "ssh_sg" {
  name        = "ssh-sg"
  description = "Allow SSH inbound"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 # Substitua pelo IP da sua máquina local
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Bucket S3
resource "aws_s3_bucket" "lab" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.lab.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Instância EC2 Ubuntu
resource "aws_instance" "app_server" {
  ami           = "ami-0360c520857e3138f"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.lab_key.key_name
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]  # ← associa SG aqui

  tags = {
    Name = "Sprint5-EC2-Ubuntu"
  }
}

# Outputs
output "bucket_name" {
  value = aws_s3_bucket.lab.bucket
}

output "ec2_public_ip" {
  value = aws_instance.app_server.public_ip
}

