FROM quay.io/nebari/nebari-jupyterlab:2024.3.2

COPY environment.yml /tmp/environment.yml

RUN mamba config --env --add channels conda-forge
RUN mamba config --env --set channel_priority strict
RUN mamba env update --prefix ${CONDA_DIR} --file /tmp/environment.yml

USER root

RUN apt-get update && apt-get install -y --no-install-recommends curl

RUN curl -sLO https://github.com/argoproj/argo-workflows/releases/download/v3.5.6/argo-linux-amd64.gz
RUN gunzip argo-linux-amd64.gz
RUN chmod +x argo-linux-amd64

# Based on https://github.com/nebari-dev/nebari-docker-images/issues/83
ENV ARGO_HOME='/opt/argo'
RUN mkdir -p ${ARGO_HOME}
RUN mv ./argo-linux-amd64 ${ARGO_HOME}/argo

ENV PATH=${ARGO_HOME}:${PATH}
ENV ARGO_SERVER='https://carbonplan.quansight.dev:443'
ENV ARGO_HTTP1=true  
ENV ARGO_SECURE=true
ENV ARGO_BASE_HREF=/argo
ENV ARGO_NAMESPACE=dev
ENV KUBECONFIG=/dev/null
