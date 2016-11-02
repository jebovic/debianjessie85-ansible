FROM debian:jessie

MAINTAINER Jérémy Baumgarth

ENV DEBIAN_FRONTEND noninteractive

# Install Ansible via pip.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential libffi-dev libssl-dev python-pip python-dev \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean
RUN pip install --upgrade pip && pip install ansible

# Install Ansible inventory file
RUN mkdir -p /etc/ansible \
    && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

COPY initctl_custom .
RUN chmod +x initctl_custom && rm -fr /sbin/initctl && ln -s /initctl_custom /sbin/initctl

CMD /bin/sh
