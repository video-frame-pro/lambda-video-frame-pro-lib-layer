######### OUTPUTS ######################################################

# ARN da Layer criada
output "lib_layer_arn" {
  value       = aws_lambda_layer_version.lib_layer.arn
  description = "ARN da Lambda Layer criada"
}
