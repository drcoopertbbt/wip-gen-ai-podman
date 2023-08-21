# Intro-GenAI-Podman

Many of my fellow Red Hatters have asked for a way to get started with Gen AI and Red Hat products. Here is a quick way to launch 2 of the popular Gen AI application enablers that I've found very helpful and useful.

The first app is a Chroma Database runnign as an http server that can processes API requests. This fixes a lot of the issues I was having with only using a local folder /my-chroma-db issues. When processing many requests I noticed a lot issues, especially when ingesting data and trying to use the chatbot using a different sessions. Yeah, I tried that. 


```bash
git clone https://github.com/drcoopertbbt/Intro-GenAI-Podman.git
```

```bash
chmod +x init.sh
```

```bash
./init.sh
```