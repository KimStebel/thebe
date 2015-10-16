FROM ubuntu:15.04

MAINTAINER Kim Stebel <kim.stebel@gmail.com>

USER root

WORKDIR /

RUN apt-get update && apt-get install -yq \
    docker.io \
    nodejs-legacy \
    npm \
    python \
    git && \
    npm install -g bower && \
    npm install -g requirejs && \
    npm install -g coffee-script

RUN git clone https://github.com/kimstebel/thebe.git thebe

WORKDIR /thebe

RUN coffee -cbm . && \
    bower --allow-root --no-interactive install

WORKDIR /thebe/static

RUN r.js -o build.js baseUrl=. name=almond include=main out=main-built.js 

WORKDIR /

CMD python -m SimpleHTTPServer 8080

EXPOSE 8080
