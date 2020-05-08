FROM  hashicorp/terraform:light

ENV PROVIDER=aws

RUN apk add curl

COPY  init.tf /terraformer/

WORKDIR /terraformer/

RUN terraform init && \
    curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/$(curl -s https://api.github.com/repos/GoogleCloudPlatform/terraformer/releases/latest | grep tag_name | cut -d '"' -f 4)/terraformer-${PROVIDER}-linux-amd64 && \
    chmod +x terraformer-${PROVIDER}-linux-amd64 && \
    mv terraformer-${PROVIDER}-linux-amd64 /usr/local/bin/terraformer
