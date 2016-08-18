FROM ubuntu:latest

RUN apt-get update && \
    apt-get -y install make && \
    apt-get -y install curl && \
    apt-get -y install sudo && \
    apt-get -y install pkg-config && \
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
    apt-get install --yes nodejs

RUN apt-get -y install protobuf-c-compiler && \
    apt-get -y install libprotobuf-c-dev

ADD . /code
WORKDIR /code

RUN npm install

CMD npm test
