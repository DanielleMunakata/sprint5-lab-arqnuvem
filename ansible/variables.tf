# infra/variables.tf

variable "aws_region" {
  description = "Região da AWS"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Nome do bucket S3"
  default     = "lab-sprint5-arqnuvem-danielle123"
}
