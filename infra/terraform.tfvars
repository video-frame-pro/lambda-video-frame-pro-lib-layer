######### PREFIXO DO PROJETO ###########################################
prefix_name = "video-frame-pro"  # Prefixo para nomear todos os recursos

######### AWS CONFIGURATION ############################################
aws_region      = "us-east-1"     # Região AWS onde os recursos serão provisionados

######### S3 BUCKET CONFIGURATION ######################################
s3_bucket_name = "layers"  # Nome do bucket S3 (irá adicionar o prefix automaticamente)

######### LAYER CONFIGURATION ##########################################
layer_name           = "lib-layer"       # Nome da Layer
compatible_runtimes  = ["python3.12"]    # Lista de runtimes compatíveis
