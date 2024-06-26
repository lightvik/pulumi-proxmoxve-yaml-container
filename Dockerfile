ARG PULUMI_VERSION

FROM pulumi/pulumi:${PULUMI_VERSION}

ARG PROXMOXVE_PLUGIN_VERSION
ARG IMAGE_AUTHOR='lightvik@yandex.ru'
ARG ARCH='amd64'
ARG OS='linux'

LABEL org.opencontainers.image.authors="${IMAGE_AUTHOR}"

VOLUME /root/.pulumi

RUN apt update \
&& apt install -y bash-completion \
&& apt clean

RUN pulumi gen-completion bash > /etc/bash_completion.d/pulumi

COPY --chown=root:root --chmod=0644 .bashrc /root/.bashrc

RUN pip install jinjanator

RUN curl \
--location \
"https://github.com/muhlba91/pulumi-proxmoxve/releases/download/v${PROXMOXVE_PLUGIN_VERSION}/pulumi-resource-proxmoxve-v${PROXMOXVE_PLUGIN_VERSION}-${OS}-${ARCH}.tar.gz" \
--output /tmp/proxmove.tar.gz \
&& \
pulumi plugin install resource proxmoxve ${PROXMOXVE_PLUGIN_VERSION} -f /tmp/proxmove.tar.gz \
&& \
rm --force /tmp/proxmove.tar.gz

RUN pulumi login --local

WORKDIR /projects

ENTRYPOINT []
