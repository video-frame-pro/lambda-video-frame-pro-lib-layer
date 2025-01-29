######### PREFIXO DO PROJETO ###########################################
variable "prefix_name" {
  description = "Prefixo para nomear todos os recursos do projeto"
}

######### AWS CONFIGURATION ############################################
variable "aws_region" {
  description = "Região AWS onde os recursos serão provisionados"
}

######### S3 BUCKET CONFIGURATION ######################################
variable "s3_bucket_name" {
  description = "Nome do bucket S3 onde a Layer será armazenada"
}

######### LAYER CONFIGURATION ##########################################
variable "layer_name" {
  description = "Nome da Layer"
}

variable "compatible_runtimes" {
  description = "Lista de runtimes compatíveis para a Layer"
  type        = list(string)
}
