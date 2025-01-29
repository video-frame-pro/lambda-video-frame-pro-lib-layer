#!/bin/bash

set -e  # Para interromper o script em caso de erro

echo "🚀 Iniciando Build da Layer..."

# Criar estrutura da Layer
mkdir -p layer/bin
mkdir -p layer/python/lib/python3.12/site-packages

# Baixar FFmpeg estático
echo "📥 Baixando FFmpeg..."
FFMPEG_URL="https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz"
curl -L $FFMPEG_URL -o ffmpeg.tar.xz
tar -xvf ffmpeg.tar.xz --strip-components=1 --wildcards '*/ffmpeg' -C layer/bin
chmod +x layer/bin/ffmpeg

# Instalar bibliotecas Python
echo "🐍 Instalando dependências Python..."
pip install -r scripts/requirements.txt -t layer/python/lib/python3.12/site-packages

# Criar o ZIP da Layer
echo "📦 Criando o pacote da Layer..."
cd layer
zip -r9 ../layer.zip .
cd ..

echo "✅ Layer empacotada com sucesso!"