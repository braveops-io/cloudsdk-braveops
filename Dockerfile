FROM gcr.io/google.com/cloudsdktool/cloud-sdk:alpine

ARG KUBECTX_VERSION=v0.9.1

#RUN gcloud components install kubectl

RUN apk add --no-cache --update zsh sed ncurses
ADD zshrc /root/.zshrc
RUN cd /usr/local/bin && \
      curl -sL https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubectx_${KUBECTX_VERSION}_linux_x86_64.tar.gz | tar xvz

RUN cd /usr/local/bin && \
      curl -sL https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubens_${KUBECTX_VERSION}_linux_x86_64.tar.gz | tar xvz

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl



