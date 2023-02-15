ARG DEBIANVARIANT="bullseye"
# If you change the python version, you may need to change devcontainer.json accordingly (extraPaths, etc)
ARG PYTHONVERSION="3.10"
ARG ODOOVERSION="16.0"
FROM mcr.microsoft.com/devcontainers/python:0-${PYTHONVERSION}-${DEBIANVARIANT}

ARG DEBIANVARIANT
ARG ODOOVERSION

#https://mcr.microsoft.com/v2/devcontainers/python/tags/list
#https://github.com/devcontainers/images/tree/main/src/python

ENV PYTHONUNBUFFERED 1

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends build-essential ldap-utils python3-dev libldap2-dev libsasl2-dev ldap-utils tox lcov valgrind

RUN wget https://github.com/odoo/odoo/archive/refs/heads/$ODOOVERSION.zip && \
    unzip $ODOOVERSION.zip && \
    rm $ODOOVERSION.zip && \
    mv /odoo-$ODOOVERSION /odoo && \
    cd /odoo && \
    pip install --no-cache-dir -r requirements.txt

RUN chown -R vscode:vscode /odoo
# Odoo modifies the .odoorc file so instead of linking it we copy it
# RUN ln -s /workspaces/.devcontainer/.odoorc /home/vscode/.odoorc
COPY --chown=vscode:vscode .devcontainer/.odoorc /home/vscode/.odoorc

RUN echo "deb-src http://deb.debian.org/debian" ${DEBIANVARIANT} "main" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian" ${DEBIANVARIANT}-updates "main" >> /etc/apt/sources.list
RUN apt update && \
    apt install -y dos2unix gawk

COPY --chown=vscode:vscode .devcontainer/*.sh /home/vscode/
RUN dos2unix /home/vscode/**.sh && \
    chmod +x /home/vscode/**.sh

RUN ln -s /workspaces/.devcontainer/.vimrc /root/.vimrc
RUN ln -s /workspaces/.devcontainer/.vimrc /home/vscode/.vimrc
RUN ln -s /workspaces/.devcontainer/.aliases /home/vscode/.aliases
COPY .devcontainer/bash_completion.d /etc/bash_completion.d
RUN find /etc/bash_completion.d -type f -exec dos2unix {} 2>/dev/null \; || true
RUN chmod ug+x /etc/bash_completion.d/**.sh

RUN echo "for f in /etc/bash_completion.d/*; do source \$f; done" >> /home/vscode/.bashrc
RUN echo ". ~/.aliases" >> /home/vscode/.bashrc
RUN echo "export ODOOVERSION=$ODOOVERSION" >> /home/vscode/.bashrc
