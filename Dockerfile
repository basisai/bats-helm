# Referencing https://github.com/hashicorp/vault-helm/blob/master/test/docker/Test.dockerfile
#
# This image is pushed to basisai/bats-helm
FROM alpine:latest
WORKDIR /root

ENV BATS_VERSION "1.2.1"

# base packages
RUN apk update && apk add --no-cache --virtual .build-deps \
    ca-certificates \
    curl \
    tar \
    bash \
    openssl \
    py-pip \
    git \
    make \
    jq

# yq
RUN pip install yq

# helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# bats
RUN curl -sSL https://github.com/bats-core/bats-core/archive/v${BATS_VERSION}.tar.gz -o /tmp/bats.tgz \
    && tar -zxf /tmp/bats.tgz -C /tmp \
    && /bin/bash /tmp/bats-core-$BATS_VERSION/install.sh /usr/local
