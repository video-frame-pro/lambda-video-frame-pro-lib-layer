######### PROVEDOR AWS #################################################
provider "aws" {
  region = var.aws_region
}

######### S3 BUCKET PARA A LAYER #######################################
resource "aws_s3_bucket" "lib_layer_bucket" {
  bucket = "${var.prefix_name}-${var.s3_bucket_name}"
}

resource "aws_s3_object" "lib_layer_zip" {
  bucket = aws_s3_bucket.lib_layer_bucket.id
  key    = "${var.prefix_name}-${var.layer_name}.zip"
  source = "${path.module}/../layer.zip"
}

######### CRIAÇÃO DA LAYER #############################################
resource "aws_lambda_layer_version" "lib_layer" {
  layer_name = "${var.prefix_name}-${var.layer_name}"
  s3_bucket  = aws_s3_bucket.lib_layer_bucket.id
  s3_key     = aws_s3_object.lib_layer_zip.key

  compatible_runtimes      = var.compatible_runtimes
  compatible_architectures = ["x86_64"]

  description = "Reusable Lambda Layer for Binaries & Python Libraries"
}

######### PERMISSÃO PARA A LAYER #######################################
resource "aws_lambda_layer_version_permission" "lib_layer_permission" {
  layer_name     = aws_lambda_layer_version.lib_layer.layer_name
  version_number = aws_lambda_layer_version.lib_layer.version
  statement_id   = "AllowAccountAccess"
  action         = "lambda:GetLayerVersion"
  principal      = "*"
}
