FROM python:3.10-slim-bookworm as builder

RUN apt-get update --fix-missing && apt-get install -y --fix-missing \
    build-essential \
    gcc \
    git \
    g++ && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /install
WORKDIR /install

COPY ./requirements.txt requirements.txt

RUN git clone https://github.com/chroma-core/chroma.git /chroma-git

RUN pip install --no-cache-dir --upgrade --prefix="/install" -r requirements.txt

FROM python:3.10-slim-bookworm as final

RUN apt-get update --fix-missing && apt-get install -y --fix-missing \
    build-essential \
    gcc \
    g++ && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /chroma
WORKDIR /chroma

COPY --from=builder /install /usr/local
COPY --from=builder /chroma-git /chroma
COPY ./bin/docker_entrypoint.sh /docker_entrypoint.sh

EXPOSE 8000

CMD ["/docker_entrypoint.sh"]
