provider "aws" {
  region = var.aws_region
}

# Bucket S3
resource "aws_s3_bucket" "lab" {
  bucket = "lab-sprint5-arqnuvem-danielle123" # altere para um nome único
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.lab.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Instância EC2 Ubuntu
resource "aws_instance" "app_server" {
  ami           = "ami-0360c520857e3138f" # Ubuntu 24.04 (HVM, SSD)
  instance_type = "t2.micro"

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

