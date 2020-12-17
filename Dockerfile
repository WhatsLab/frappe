ARG BASE_IMAGE=3.7.6-alpine3.11
FROM python:$BASE_IMAGE

# set our environment variable
ENV MUSL_LOCPATH="/usr/share/i18n/locales/musl"
ENV LANGUAGE=C.UTF-8
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# install libintl
# then install dev dependencies for musl-locales
# clone the sources
# build and install musl-locales
# remove sources and compile artifacts
# lastly remove dev dependencies again
RUN apk --no-cache add libintl && \
    apk --no-cache --virtual .locale_build add cmake make musl-dev gcc gettext-dev git && \
    git clone https://gitlab.com/rilian-la-te/musl-locales && \
    cd musl-locales && cmake -DLOCALE_PROFILE=OFF -DCMAKE_INSTALL_PREFIX:PATH=/usr . && make && make install && \
    cd .. && rm -r musl-locales && \
    apk del .locale_build

# install packages
RUN apk --no-cache update \
    && apk --no-cache upgrade \
    && apk add --no-cache wkhtmltopdf \
    yarn   \
    git    \
    nodejs \
    mariadb-dev \
    openssl-dev \
    wkhtmltopdf \
    curl \
    gcc \
    g++ \
    make \
    sudo \
    postgresql-client \
    curl \
    gnupg

# Add frappe user and setup sudo
RUN addgroup -g 1000 frappe \
  && adduser -D -s /bin/bash -u 1000 -g 1000 -G root frappe \
  && printf '# Sudo rules for frappe\nfrappe ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/frappe


COPY start_up.sh /home/frappe/
RUN chown -R 1000:1000 /home/frappe

USER frappe
WORKDIR /home/frappe
