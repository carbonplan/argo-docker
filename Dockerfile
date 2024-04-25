FROM quay.io/nebari/nebari-jupyterlab:2024.3.2

USER root

RUN apt-get update && apt-get install -y --no-install-recommends curl

RUN curl -sLO https://github.com/argoproj/argo-workflows/releases/download/v3.5.6/argo-linux-amd64.gz
RUN gunzip argo-linux-amd64.gz
RUN chmod +x argo-linux-amd64

# Based on https://github.com/nebari-dev/nebari-docker-images/issues/83

RUN mv ./argo-linux-amd64 /usr/local/bin/argo
ENV ARGO_SERVER='https://carbonplan.quansight.dev:443'
ENV ARGO_HTTP1=true  
ENV ARGO_SECURE=true
ENV ARGO_BASE_HREF=/argo
ENV ARGO_NAMESPACE=dev
ENV KUBECONFIG=/dev/null
