#!/bin/bash

set -e  # Interrompe o script em caso de erro

echo "🚀 Iniciando Build da Layer..."

# Criar estrutura da Layer
mkdir -p layer/bin
mkdir -p layer/python/lib/python3.12/site-packages

# Baixar FFmpeg estático
echo "📥 Baixando FFmpeg..."
FFMPEG_URL="https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz"
curl -L $FFMPEG_URL -o ffmpeg.tar.xz
mkdir -p ffmpeg-temp
tar -xvf ffmpeg.tar.xz -C ffmpeg-temp --strip-components=1
mv ffmpeg-temp/ffmpeg layer/bin/ffmpeg
chmod +x layer/bin/ffmpeg
rm -rf ffmpeg-temp ffmpeg.tar.xz

# Instalar bibliotecas Python, se o arquivo existir
if [[ -f scripts/requirements.txt ]]; then
  echo "🐍 Instalando dependências Python..."
  pip install -r scripts/requirements.txt -t layer/python/lib/python3.12/site-packages
else
  echo "⚠️ Aviso: Arquivo requirements.txt não encontrado. Pulando instalação de dependências."
fi

# Criar o ZIP da Layer
echo "📦 Criando o pacote da Layer..."
cd layer
zip -r9 ../layer.zip .
cd ..

echo "✅ Layer empacotada com sucesso!"
