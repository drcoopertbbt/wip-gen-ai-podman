# Intro-GenAI-Podman

Many of my fellow Red Hatters have asked for a way to get started with Gen AI and Red Hat products. Here is a quick way to launch 2 of the popular Gen AI application enablers that I've found very helpful and useful.

The first app is a Chroma Database runnign as an http server that can processes API requests. This fixes a lot of the issues I was having with only using a local folder /my-chroma-db issues. When processing many requests I noticed a lot issues, especially when ingesting data and trying to use the chatbot using a different sessions. Yeah, I tried that. 


    - I'm using Fedora 38 on a VM

```bash
git clone https://github.com/drcoopertbbt/Intro-GenAI-Podman.git
cd Intro-GenAI-Podman
```

```bash
sudo dnf install python3-devel
sudo dnf install gcc-c++ -y

```

# Create Python Virtual Environment with chromadb

```bash
python -m venv venv-chroma
source venv-chroma/bin/activate
pip install chromadb langchain beautifulsoup4 lxml openai
pip install --upgrade pip
```


# Build ChromaDB container

This build command uses the Dockerfile in /chroma-container and sets that as the build context.

```bash
podman build chroma-container -t localhost/chroma/build
```


# Run ChromaDB server


```bash
podman run -d --rm \
--name chromadb \
-p 8000:8000 \
-v chromadb-chroma:/chroma \
-v chromadb-index_data:/index_data \
localhost/chroma/build
```

podman run --entrypoint

# Run Flowise server

I selected dockerhub.

```bash
podman run -d --rm \
--name flowise \
-p 3000:3000 \
flowiseai/flowise flowise start
```