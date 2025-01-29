<p align="center">
  <img src="https://i.ibb.co/zs1zcs3/Video-Frame.png" width="30%" />
</p>

---

# Video Frame Pro - Lambda Layer

Este repositório contém a **Lambda Layer** do sistema **Video Frame Pro**, projetada para fornecer dependências reutilizáveis para diversas funções Lambda, incluindo **binaries (FFmpeg)** e **bibliotecas Python** necessárias para o processamento de vídeos.

---

## 📌 Objetivo

A **Lambda Layer** contém as seguintes dependências:

- **FFmpeg**: Para manipulação de vídeos (extração de frames, conversão, etc.).
- **Pillow**: Para manipulação de imagens em Python.
- **boto3**: SDK oficial da AWS para Python.
- **NumPy**: Biblioteca para operações numéricas e manipulação de arrays.
- **OpenCV (Headless)**: Processamento de imagens e visão computacional.

Essa Layer pode ser reutilizada por várias Lambdas dentro do sistema, reduzindo o tamanho do código e melhorando a eficiência do deploy.

---

## 📂 Estrutura do Repositório

```
/meu-repo-layer
├── layer
│   ├── bin
│   │   ├── ffmpeg                         # Executável FFmpeg
│   ├── python
│   │   ├── lib/python3.12/site-packages   # Bibliotecas Python instaladas
├── scripts
│   ├── build.sh                           # Script para empacotar a Layer
│   ├── requirements.txt                   # Lista de dependências Python
├── infra                                  # Código Terraform para provisionamento
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars

```

---

## 🚀 Configuração e Deploy

### 1️⃣ Pré-requisitos

1. Ter o **AWS CLI** instalado e configurado (`aws configure`).
2. Ter o **Terraform** instalado (`terraform -v`).
3. Ter permissão para criar **Lambda Layers** e **S3 Buckets**.

### 2️⃣ Criando e Publicando a Layer

```sh
# Clonar o repositório
git clone https://github.com/seuusuario/video-frame-pro-lib.git
cd video-frame-pro-lib

# Construir a Layer
chmod +x scripts/build.sh
scripts/build.sh

# Deploy da Infraestrutura AWS
cd infra
terraform init
terraform apply -auto-approve
```

Após a execução, a Layer será publicada na AWS e poderá ser usada por outras Lambdas.

---

## 🛠 Como Usar a Layer em Outras Lambdas?

### No Terraform

```hcl
resource "aws_lambda_function" "lambda_processing" {
  function_name = "video-frame-processing"
  handler       = "processing.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_role.arn
  filename      = "lambda_processing.zip"
  source_code_hash = filebase64sha256("lambda_processing.zip")

  layers = [aws_lambda_layer_version.lib_layer.arn]

  environment {
    variables = {
      BUCKET_NAME = "video-frame-pro-layers-s3"
    }
  }
}
```

---

## 📜 Licença

Este projeto está licenciado sob a **MIT License**. Consulte o arquivo LICENSE para mais detalhes.

---

Desenvolvido com ❤️ pela equipe **Video Frame Pro**.
