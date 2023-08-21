#!/bin/bash

# Create Python Virtual Environment with chromadb
python -m venv venv-chroma
source venv-chroma/bin/activate
pip install chromadb langchain beautifulsoup4 lxml openai


# Build ChromaDB container
podman build chroma-container -t localhost/chroma/build

# Run ChromaDB server
podman run -d --rm --name chromadb -p 8000:8000 -v chromadb-chroma:/chroma -v chromadb-index_data:/index_data localhost/chroma/build

# Run Flowise server
podman run -d --rm --name flowise -p 3000:3000 flowiseai/flowise flowise start

echo "Flowise server available at http://localhost:3000"
echo "ChromaDB server available at http://localhost:8000"

